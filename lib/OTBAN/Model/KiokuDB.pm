package OTBAN::Model::KiokuDB;
use Moose;

BEGIN { extends qw(Catalyst::Model::KiokuDB) }

# this is probably best put in the catalyst config file instead:
__PACKAGE__->config( dsn => "dbi:SQLite:otban.sqlite" );

1;
