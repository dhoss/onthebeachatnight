use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'OTBAN' }
BEGIN { use_ok 'OTBAN::Controller::API' }

ok( request('/api')->is_success, 'Request should succeed' );


