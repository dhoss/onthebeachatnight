package OTBAN::Controller::Forums;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

OTBAN::Controller::Forums - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched OTBAN::Controller::Forums in Forums.');
}


=head1 AUTHOR

Devin Austin
http://www.codedright.net
dhoss@cpan.org

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
