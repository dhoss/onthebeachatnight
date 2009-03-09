package OTBAN::Controller::Thread;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

OTBAN::Controller::Thread - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    ## will be changed
    my $html = qq{
    <h2> post a new thread </h2>
    <form method="post" action="/threads/request" enctype="application/json">
    <label for="title">Title:</label><input type="text" name="title" id="title" />
    </form>
    };
    
    $c->response->body($html);
    
}


=head1 AUTHOR

Devin Austin,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
