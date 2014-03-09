use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';
use Game ':ALL';

can_ok 'Game', 'new';

done_testing;
