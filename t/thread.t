use strict;
use warnings;
use Test::More tests => 11;

BEGIN { use_ok 'OTBAN::Thread' }
BEGIN { use_ok 'Moose' }
BEGIN { use_ok 'KiokuDB::Util' }

my $thread = OTBAN::Thread->new( title => 'test' );
ok( $thread, 'Created a thread okay' );

my $child = OTBAN::Thread->new( title => 'child' );
ok( $thread->add_child( $child ), "Added a child");
is( $thread->children->members, $child, "Child node is a child of this thread");
is( $thread->children->size, 1, "One child");
is( $child->parent, $thread, "Root node is parent");
is( $child->siblings->size, 1, "One sibling");
my $child2 = OTBAN::Thread->new( title => 'child2' );
ok($child->children->insert($child2), "Child added to child2");
is($child->children->size, 1, "Child has Two siblings");

