package My::App::Backend::Kioku;
use Moose;

use KiokuDB;
use Data::Visitor::Callback;
use Scalar::Util               qw(blessed refaddr);
use My::App::TypeMap           qw(get_typemap);
use MooseX::Types::Path::Class qw(Dir);
use List::Util                 qw(first);

use namespace::clean -except => 'meta';

use Search::GIN::Extract::Callback;
use Search::GIN::Query::Manual;

has storage => (
    is       => 'ro',
    isa      => Dir,
    required => 1,
    coerce   => 1,
);

has extra_options => (
    is         => 'ro',
    isa        => 'HashRef',
    default    => sub { +{} },
    auto_deref => 1,
);

has backend_class => (
    is       => 'ro',
    isa      => 'ClassName',
    required => 1,
    default  => sub {
        require KiokuDB::Backend::BDB::GIN;
        return 'KiokuDB::Backend::BDB::GIN';
    },
);

has db => (
    is      => 'ro',
    isa     => 'KiokuDB',
    lazy_build => 1,
    handles => [qw(
        new_scope
        lookup
        store
        insert
        update
        search
        delete
        object_to_id
        objects_to_ids
        live_objects
        txn_do
    )],
);

sub _build_db {
    my $self = shift;

    my @extra = $self->extra_options;

    return KiokuDB->new(
        typemap => get_typemap(),
        backend => $self->backend_class->new(
            manager => {
                home => $self->storage,
                @extra,
            },
            extract => $self->gin_extractor,
            @extra,
        ),
        @extra,
    );
}

has gin_extractor => (
    does => "Search::GIN::Extract",
    is   => "ro",
    lazy_build => 1,
);

sub _build_gin_extractor {
    my ( $self, %args ) = @_;

    Search::GIN::Extract::Callback->new(
        extract => sub {
            my ( $obj, $gin, %args ) = @_;

            my $l = $args{live_objects};

            if ( $obj->isa("My::App::Schema::Tag" ) ) {
                return {
                    tag_name => $obj->name,
                    type     => "tag",
                };
            } elsif ( $obj->isa("My::App::Schema::User") ) {
                return {
                    ldap_id => $obj->ldap_id,
                    type    => "user",
                };
            } elsif ( $obj->isa("My::App::Schema::Tutorial") ) {
                return {
                    type => "tutorial",
                };
            } elsif ( $obj->isa("My::App::Schema::Country") ) {
                return {
                    country_name => $obj->name,                    
                    type         => "country",
                };
            } elsif ( $obj->isa("My::App::Schema::Curriculum") ) {
                return;
            }

            return;
        },
    );
}

my ( $users, $tags, $tutorials, $countries ) = map {
    Search::GIN::Query::Manual->new( values => { type => $_ } )
} qw(user tag tutorial country);

sub list_users {
    my $self = shift;
    $self->search($users);
}

sub list_tutorials {
    my $self = shift;
    $self->search($tutorials);
}

sub list_tags {
    my $self = shift;
    $self->search($tags);
}

sub list_countries {
    my $self = shift;
    $self->search($countries);
}

sub _find {
    my ( $self, @key ) = @_;

    my $rs = $self->search( Search::GIN::Query::Manual->new( values => {@key} ) );

    if ( my $block = $rs->next ) {
        return $block->[0];
    } else {
        return;
    }
}

sub get_country_by_name {
    my ( $self, $name ) = @_;

    $self->_find( country_name => $name );
}

sub get_sorted_country_list {
    my $self = shift;
    sort { $a->name cmp $b->name } $self->list_countries->all
}

sub get_user_by_ldap_id {
    my ( $self, $ldap_id ) = @_;

    $self->_find( ldap_id => $ldap_id );
}

sub find_tags {
    my ( $self, @names ) = @_;

    my $query = Search::GIN::Query::Manual->new(
        method => "any",
        values => { tag_name => \@names },
    );

    my %objs;
    @objs{@names} = $self->search($query)->all;

    if ( grep { not defined } values %objs ) {
        die "tags not found: " . join(", ", grep { not defined $objs{$_} } @names);
    } else {
        return @objs{@names};
    }
}

sub find_tag {
    my ( $self, $tag_name ) = @_;

    $self->_find( tag_name => $tag_name );
}

sub find_or_create_tag {
    my ($self, $tag_name) = @_;

    if ( my $found = $self->find_tag($tag_name) ) {
        return $found;
    } else {
        my $new = My::App::Schema::Tag->new( name => $tag_name );

        $self->insert($new);

        return $new;
    }
}

sub store_tutorial {
    my ($self, $tutorial) = @_;

    # add "back" references
    $tutorial->author->tutorials->insert($tutorial);
    $_->tutorials->insert($tutorial) for $tutorial->tags->members;
    $tutorial->nav_tag->tutorials->insert($tutorial);

    # fixup dates
    $tutorial->touch;

    my $id = $self->object_to_id($tutorial);

    if ( $id ) {
        $self->update($tutorial);
    } else {
        $id = $self->insert($tutorial);
    }

    $self->update( $tutorial->author, $tutorial->nav_tag, $tutorial->tags->members );

    return $id;
}

# run this in a txn along with edit and re-store
sub remove_tutorial_relations {
    my ($self, $tutorial) = @_;

    # remove "back" references
    $tutorial->author->tutorials->remove($tutorial);
    $_->tutorials->remove($tutorial) for $tutorial->tags->members;
    $tutorial->nav_tag->tutorials->remove($tutorial);

    $self->store($tutorial->author);
    $self->store($_) for $tutorial->tags->members;
    $self->store($tutorial->nav_tag);

    return;
}

sub delete_tutorial {
    my ($self, $tutorial) = @_;

    $self->txn_do(sub{
        $self->remove_tutorial_relations($tutorial);
        $self->delete($tutorial);
    });

    return;
}


1;


