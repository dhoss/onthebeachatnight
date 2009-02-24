package OTBAN::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'OTBAN::Schema',
    connect_info => [
        'dbi:SQLite:otban.db',
        
    ],
);

=head1 NAME

OTBAN::Model::DB - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<OTBAN>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<OTBAN::Schema>

=head1 AUTHOR

Devin Austin,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
