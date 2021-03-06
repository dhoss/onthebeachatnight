use strict;
use warnings;
use Test::More tests => 15;

## make sure we can use everything
BEGIN { use_ok 'OTBAN::Thread' }
BEGIN { use_ok 'OTBAN::User' }
BEGIN { use_ok 'OTBAN::Message' }
BEGIN { use_ok 'Moose' }
BEGIN { use_ok 'KiokuDB::Util' }
BEGIN { use_ok 'DateTime' }

## create a thread
my $message = OTBAN::Message->new( title => 'test', created => DateTime->now, 
    author => OTBAN::User->new( name => 'Devin' ));
my $thread = OTBAN::Thread->new( message => $message );
ok( $thread, 'Created a thread okay' );
is( $message->title, "test", "Thread's title is 'test'");
is( $message->author->name, "Devin", "Thread's author is 'Devin'");
isa_ok( $message->created, "DateTime", "Thread's created on is a DateTime object");

## create a child for $thread
my $message2 = OTBAN::Message->new(title => 'child', content => 'blargh');
my $child = OTBAN::Thread->new( message => $message2 );
ok( $thread->add_message( $child), "Added a child");

## make sure we can get the thread's children and number of children
is( $thread->tree->child_count, 1, "Thread has one child" );
#is( $thread->tree->get_child_at(0), $child->tree, "Child node is a child of this thread");
is( $thread->tree->child_count, 1, "One child");
#ok( $thread->get_child_at(0)->is_child_of(tree), "Root node is parent");

## add a child to $child
my $message3 = OTBAN::Message->new( title => 'child2', content=>'blargh' );
my $child2 = OTBAN::Thread->new( message => $message3 );
## need to make this more purdy
ok($thread->tree->get_child_at(0)->add_child(Forest::Tree->new(node=>$child2)), "Child added to child2");
is($thread->tree->get_child_at(0)->child_count, 1, "Child has 1 child");

## let's traverse our tree


