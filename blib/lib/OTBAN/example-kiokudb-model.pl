package My::App::Model::Kioku;
use Moose;
use My::App::Backend::Kioku;

has 'backend' => (
    is       => 'ro',
    isa      => 'My::App::Backend::Kioku',
    required => 1,
);

sub COMPONENT {
    my ($self, $app, $args) = @_;
    $self->new(
        backend => My::App::Backend::Kioku->new(
            %$args,
        ),
    );
}

sub ACCEPT_CONTEXT {
    my ($self, $c, @args) = @_;
    my $be = $self->backend;
    $c->stash->{__kioku_scope} ||= $be->db->new_scope;
    return $be;
}

1;
