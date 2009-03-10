package OTBAN::Controller::API::REST;
use Moose;
BEGIN { 
    extends 'Catalyst::Controller::REST', 
            'OTBAN::Controller::API::Base'; 
};


## thanks lukes! (luke.saunders)
__PACKAGE__->config(
    'default'   => 'application/json',
    'convert_blessed'   => 1,
	'stash_key' => 'response',
	    'map'       => {
		    'application/x-www-form-urlencoded' => 'JSON',
			'application/json'                  => 'JSON',
			'text/html'                         => [ 'View', 'TT' ],
		},
);


=head1 METHODS

=cut


=head2 index

Set up our ActionClass as REST

=cut

sub index : ActionClass('REST') { 
    my ($self, $c) = @_;
}


=head2 index_GET

forward to the list action.
just lists all items.

=cut

sub index_GET{
    my ( $self, $c ) = @_;

    $c->log->debug("Reached index_GET");
    $c->forward('list');
}


=head2 thread_setup

set up rest stuff for a thread

=cut

sub thread_setup : Chained('/') PathPart('threads') CaptureArgs(0) {
    my ($self, $c, $thread) = @_;
    
    ## do checking to see if $thread exists
    $c->stash->{thread} = $thread;
    

}

=head2 thread

set up our REST actionclass

=cut

sub thread : Chained('thread_setup') PathPart('request') Args(0) ActionClass('REST') {

}


=head2 thread_POST

create a thread. defaults to a parent thread.

=cut


sub thread_POST {
    my ($self, $c) = @_;
    
    $c->forward('post');
    
}


=head2 thread_GET

get a thread's information.
this gets a given thread in its entirety, with children.


=cut

sub thread_GET {
    my ($self, $c) = @_;
    
    $c->forward('item');


}

=head2 thread_PUT
=cut

sub thread_PUT{
    my ($self, $c) = @_;
    
    $c->forward('update');

}

=head2 thread_DELETE

delete a thread and it's children.

=cut

sub thread_DELETE {
    my ($self, $c) = @_;
    
    $c->forward('delete');
}

=head2 *::TO_JSON

This is to attempt to serialize our KiokuDB stuff

=cut

sub OTBAN::Controller::API::REST::TO_JSON {
    my ($self, $c) = @_;
    
    

}

1;
