use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';

use Player::GamePlayer ':ALL';

my $game_player = Player::GamePlayer->new({
    first_name => 'Alvin',
    last_name  => 'Patrimonio',
    jersey     => '16',
    team       => 'Hotdogs',
});

isa_ok $game_player, 'Player::GamePlayer';
isa_ok $game_player, 'Player'; # base class check
can_ok $game_player, 'team';

TODO: {
    local $TODO = 'GamePlayer knows how many points it scores in a game';
    can_ok $game_player, 'score_for';

    local $TODO = 'We can set a GamePlayer\'s points scored in a game';
    can_ok $game_player, 'add_score_for';

    local $TODO = 'GamePlayer knows how many points it scored in a tournament';
    can_ok $game_player, 'total_score';

    local $TODO = 'GamePlayer knows its average points per game';
    can_ok $game_player, 'average_points';

    local $TODO = 'GamePlayer knows how many games it has played';
    can_ok $game_player, 'games_played';

    local $TODO = 'GamePlayer knows how many fouls it made in a game';
    can_ok $game_player, 'fouls_for';

    local $TODO = 'GamePlayer knows how many fouls it made in a tournament';
    can_ok $game_player, 'total_fouls';

    local $TODO = 'GamePlayer knows its average fouls per game';
    can_ok $game_player, 'average_fouls';
}

done_testing;
