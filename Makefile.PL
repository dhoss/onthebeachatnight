# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'OTBAN';
all_from 'lib/OTBAN.pm';

requires 'Catalyst::Runtime' => '5.71000';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
                 
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::View::Email';
requires 'Catalyst::Controller::REST';
requires 'Catalyst::Controller::HTML::FormFu';
requires 'Catalyst::Plugin::Cache';
requires 'Cache::Memcached';
requires 'Moose';
requires 'KiokuDB';
requires 'Catalyst::Model::KiokuDB';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
