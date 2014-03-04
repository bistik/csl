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
});

isa_ok $game_player, 'Player::GamePlayer';
isa_ok $game_player, 'Player'; # base class check
isa_ok $game_player, 'UNIVERSAL'; # ancestor class check

TODO: {
    local $TODO = 'GamePlayer knows how many points it scores in a game';
    can_ok $game_player, 'score_for';

    local $TODO = 'We can set a GamePlayer\'s points scored in a game';
    can_ok $game_player, 'add_score_for';

    local $TODO = 'GamePlayer knows how many points it has scored in the tournament';
    can_ok $game_player, 'total_score';

    local $TODO = 'GamePlayer knows its average points per game';
    can_ok $game_player, 'average';

    local $TODO = 'GamePlayer knows how many games it has played';
    can_ok $game_player, 'games_played';

    local $TODO = 'GamePlayer knows which team it plays for';
    can_ok $game_player, 'team';
}

done_testing;
