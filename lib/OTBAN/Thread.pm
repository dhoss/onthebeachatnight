package OTBAN::Thread;
use Moose;
use Forest::Tree;

has tree => (
    isa => 'Forest::Tree',
    is => 'ro',
    lazy_build => 1,
    handles => {
        message_count      => 'child_count',
        get_message_number => 'get_child_at' 
    }
);

has message => (
    isa => 'OTBAN::Message',
    is  => 'rw',
);

=head2 add_message

add a message to the tree. 
$message is the Message object

=cut

sub add_message {
    my ($self, $message) = @_;
    $self->tree->add_child(
        Forest::Tree->new( 
            node => $message
        )
    );
}

sub print {
    my $self = shift;
    $self->tree->traverse( sub { print $_->content });
}


## since lazy_build => 1
sub _build_tree { 

    Forest::Tree->new( node => 'Root' ); 

}

1;

