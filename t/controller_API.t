use strict;
use warnings;
use Test::More tests => 5;

BEGIN { use_ok 'Catalyst::Test', 'OTBAN' }
BEGIN { use_ok 'OTBAN::Controller::API' }


## let's make sure our URIs are okay
ok( request('/api')->is_success, 'Request to root API should succeed' );
    
## test our URIs via REST requests ##

## GET: thread
ok( 
    request( 
        HTTP::Request->new( 
            GET => '/api/thread') 
        )->is_success, 
        'Request to thread URI should succeed'
);

## POST: thread
## i dunno if this is even the right usage. will look into it more.
ok( 
    request( 
        HTTP::Request->new( 
            POST => '/api/thread') 
        )->is_success, 
        'Request to thread URI should succeed'
);

