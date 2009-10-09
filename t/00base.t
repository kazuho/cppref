use strict;
use warnings;

use Test::More tests => 7;

is(system("blib/script/cppref > /dev/null"), 0, 'top page');
is(system("blib/script/cppref stl::vector::push_back > /dev/null"), 0, 'exact path');
is(system("blib/script/cppref stl/vector/push_back > /dev/null"), 0, 'exact path using slashes');
is(system("blib/script/cppref stl > /dev/null"), 0, 'dir');
is(system("blib/script/cppref faq > /dev/null"), 0, 'search');
is(system("blib/script/cppref hokhokhok > /dev/null 2>&1"), 256, 'not found');
is(system("blib/script/cppref push_back > /dev/null 2>&1"), 0, 'multiple choices');

