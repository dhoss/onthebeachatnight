use strict;
use warnings;
use Test::More tests => 5;

BEGIN { use_ok 'Catalyst::Test', 'OTBAN' }
BEGIN { use_ok 'OTBAN::Controller::Thread' }

ok( request('/thread')->is_success, 'Request should succeed' );

use ok "Test::WWW::Mechanize::Catalyst" => "OTBAN";
my $ua1 = Test::WWW::Mechanize::Catalyst->new;

$ua1->submit_form(
    fields => {
        title => 'testing creating a parent node',
     }
);

