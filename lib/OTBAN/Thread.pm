package OTBAN::Thread;

use Moose;
use KiokuDB::Util qw[weak_set];
has 'node' => (is => 'rw', isa => 'Any');

has 'title' => (

    isa => "Str",
    is  => "rw",

);

has 'children' => (

    does    => "KiokuDB::Set",
    is      => "rw",
    default => sub { weak_set() }

);

has 'parent' => (
      is          => 'rw',
      isa         => __PACKAGE__,
      weaken => 1,
      handles     => {
          parent_node => 'node',
          siblings    => 'children',
      },
      
);

## thanks perigrin
sub add_child { 

    my ($self, $child) = @_; 
    $child->parent($self); 
    $self->children->insert($child); 

}


1;
