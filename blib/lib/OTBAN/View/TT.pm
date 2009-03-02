package OTBAN::View::TT;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config( 
        # Change default TT extension
        TEMPLATE_EXTENSION => '.tt2',
        # Set the location for TT files
        INCLUDE_PATH => [
                OTBAN->path_to( 'root','site' ),
        ],
);

=head1 NAME

OTBAN::View::TT - TT View for OTBAN

=head1 DESCRIPTION

TT View for OTBAN. 

=head1 SEE ALSO

L<OTBAN>

=head1 AUTHOR

Devin Austin
http://www.codedright.net
dhoss@cpan.org

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
