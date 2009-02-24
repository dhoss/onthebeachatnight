package OTBAN::View::Email;

use strict;
use base 'Catalyst::View::Email';

__PACKAGE__->config(
    stash_key => 'email'
);

=head1 NAME

OTBAN::View::Email - Email View for OTBAN

=head1 DESCRIPTION

View for sending email from OTBAN. 

=head1 AUTHOR

Devin Austin,,,

=head1 SEE ALSO

L<OTBAN>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
