package OTBAN::User;

use Moose;

has 'name' => (

    isa => 'Str',
    is  => 'rw',

);

1;
