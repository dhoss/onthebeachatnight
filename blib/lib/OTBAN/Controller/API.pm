package OTBAN::Controller::API;

use strict;
use warnings;
use parent 'Catalyst::Controller::REST';

=head1 NAME

OTBAN::Controller::API - Catalyst Controller

=head1 DESCRIPTION

This is going to do the bulk of the stuff for the site.
Everything is going to make REST requests to this controller and
display accordingly.

=head1 METHODS

=cut


=head2 index

Just return some documentation here? i dunno.

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched OTBAN::Controller::API in API.');
}



=head2 thread

set up rest stuff for a thread

=cut

sub thread : Local : ActionClass('REST') { }

=head2 thread_POST

create a thread. defaults to a parent thread.

=cut


sub thread_POST {
    my ($self, $c) = @_;
    
    ## insert code goes here

    return $self->status_created(
        $c,
        location => ,        ## return location of the new thread
        entity => {
            post_success =>, ## determine whether the thread was posted successfully
                             ## or not
        }
    );
    
}


=head2 thread_GET

get a thread's information.
this gets a given thread in its entirety, with children.


=cut

sub thread_GET {
    my ($self, $c) = @_;
    
    ## get code goes here
    
    return $self->status_ok(
        $c, 
        entity => {
            thread =>, ## return our thread 
        },    
    
    );


}

=head2 thread_PUT
=cut

sub thread_PUT{}

=head2 thread_DELETE

delete a thread and it's children.

=cut

sub thread_DELETE {
    my ($self, $c) = @_;
    
    ## delete code goes here
    
    return $self->status_ok(
        $c, 
        entity => {
            thread_delete_ok =>, ## deteremine if thread was deleted
        }
    );


=head1 AUTHOR

Devin Austin
http://www.codedright.net
dhoss@cpan.org

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
