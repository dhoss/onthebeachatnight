package OTBAN::Controller::API::Base;
use base 'Catalyst::Controller';


=head1 NAME

OTBAN::Controller::API - Catalyst Controller

=head1 DESCRIPTION

Base class for API methods.

=head1 METHODS

=cut


=head2 index


=cut

sub index : Private {

    my ($self, $c) = @_;
    return "Index!";

}


=head2 post

post a new thread

=cut

sub post : Private {
    my ($self, $c) = @_;
    
    return "Post an item";

}

=head2 put

put/update an item

=cut

sub put : Private {
    my ($self, $c) = @_;
    
    return "update an item";

}


=head2 delete

delete an item

=cut

sub delete : Private {
    my ($self, $c) = @_;
    
    return "delete an item";
    
}

=head2 list

list all items

=cut

sub list : Private {
    my ($self, $c) = @_;
    
    $c->log->debug("Reached list");
    return "Hi!";
    
}

=head2 item

list one item

=cut

sub item : Private {
    my ($self, $c) = @_;
    
    my $id = $c->stash->{thread};
    $c->model('KiokuDB')->lookup($id);
    
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