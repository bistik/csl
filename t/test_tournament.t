use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';
use Tournament ':ALL';

my $tournament = Tournament->new;
isa_ok $tournament, 'Tournament';

TODO: {
    local $TODO = 'Tournament should know have teams';
    can_ok 'Tournament', 'teams';

    local $TODO = 'Tournament can check if a team is a participant';
    can_ok 'Tournament', 'team_exists';
}
