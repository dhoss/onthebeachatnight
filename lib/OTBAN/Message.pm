package OTBAN::Message;
use Moose;

has 'title' => (
    isa => "Str",
    is  => "rw",
);

has 'created' => (
    isa      => 'DateTime',
    is       => 'rw',
    default  => sub { DateTime->now() }
);

has 'author' => (
    isa     => 'OTBAN::User',
    is      => 'rw',
);

has 'content' => (
    isa => 'Str',
    is  => 'rw',
);

has 'thread' => (

    isa => 'OTBAN::Thread',
    is  => 'rw',

);

1;
