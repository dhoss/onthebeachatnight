package OTBAN::Thread;

use Moose;
use KiokuDB::Util qw[set];
has 'node' => (is => 'rw', isa => 'Any');

has 'title' => (

    isa => "Str",
    is  => "rw",

);

has 'children' => (

    does => "KiokuDB::Set",
    is   => "rw",

);

has 'parent' => (
      is          => 'rw',
      isa         => __PACKAGE__,
      weak_ref => 1,
      handles     => {
          parent_node => 'node',
          siblings    => 'children',
      }
);


sub add_child {

    my ( $self, @children ) = shift;
    my $parent              = $self->parent;
    my $set                 = set ( @children );
    $parent->children($set);
    
}

1;
