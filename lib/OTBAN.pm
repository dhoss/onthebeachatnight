use Moose ();

package OTBAN;

use strict;
use warnings;

use Catalyst::Runtime '5.70';

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use parent qw/Catalyst/;
use Catalyst qw/
                
                -Debug
                ConfigLoader
                Static::Simple
                
                StackTrace
                
                Cache
                
                /;
our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in otban.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config( name => 'OTBAN' );


# config for Cache::Memcached::libmemcached
__PACKAGE__->config->{'Plugin::Cache'}{backend} = {
    class   => "Cache::Memcached",
    servers => ['127.0.0.1:11211'],
    debug   => 2,
};

# Start the application
__PACKAGE__->setup();


=head1 NAME

OTBAN - Catalyst based application

=head1 SYNOPSIS

    script/otban_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<OTBAN::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Devin Austin
http://www.codedright.net
dhoss@cpan.org

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
