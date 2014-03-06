use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';
use Tournament ':ALL';

my $tournament = Tournament->new(
        { teams => [ "Misfits", "TteamO", "Cyberstars", "Cybergilas" ] }
    );
isa_ok $tournament, 'Tournament';

can_ok 'Tournament', 'teams';
is ref $tournament->teams, 'ARRAY',
        'tournament->teams should return an array ref';
my @teams = @{$tournament->teams};
my @expected_teams = qw(Misfits TteamO Cyberstars Cybergilas);
is @teams, @expected_teams, 'tournament->teams should return participating teams:';

can_ok 'Tournament', 'team_exists';
is 1, $tournament->team_exists('Misfits'),
    'tournament->team_exists should return true for participating teams';
is 0, $tournament->team_exists('Bulls'),
    'tournament->team_exist should return false for non-participating teams' ;

TODO: {
    local $TODO = 'Tournament can show info on team (schedule,players+stats,win,loss)';
    can_ok 'Tournament', 'team_info';
}

done_testing;
