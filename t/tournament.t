use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';
use Tournament ':ALL';
use Player::GamePlayer ':ALL';

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

can_ok 'Tournament', 'add_player';

my $game_player = Player::GamePlayer->new({
    first_name => 'Alvin',
    last_name  => 'Patrimonio',
    jersey     => '16',
    team       => 'Misfits',
});

my $duplicate_player = Player::GamePlayer->new({
    first_name => 'Sonny',
    last_name  => 'Jaworski',
    jersey     => '16', # same jersey as Alvin
    team       => 'Misfits', # same team as Alvin
});

my $alien_game_player = Player::GamePlayer->new({
    first_name => 'Alvin',
    last_name  => 'Patrimonio',
    jersey     => '16',
    team       => 'Hotdogs', # Hotdogs is not in the tournament
});

my $not_a_game_player = 1;

throws_ok { $tournament->add_player }
        qr/Missing player argument for add_player/,
        'tournament->add_player throws exception if there is no player
        argument';
throws_ok { $tournament->add_player($not_a_game_player) }
       qr/Argument for add_player must be of type Player::GamePlayer/,
       'tournament->add_player throws exception if arg is not a GamePlayer';

can_ok 'Tournament', 'player_exists';

is $tournament->add_player($game_player), 1, 'each add_player call should increase
player count by 1';
is $tournament->player_exists($duplicate_player), 1, 'player_exists returns
true for duplicate players';
throws_ok { $tournament->add_player($duplicate_player) }
    qr/is already registered/,
    'tournament->add_player throws exception if player already exists';

throws_ok { $tournament->add_player($alien_game_player) }
    qr/team is not competing in this tournament/,
    'tournament->add_player throws exception if players team is not in the
    tournement';

TODO: {
    local $TODO = 'Tournament can show info on team (schedule,players+stats,win,loss)';
    can_ok 'Tournament', 'team_info';
}

done_testing;
