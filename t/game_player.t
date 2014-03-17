use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';

use Player::GamePlayer ':ALL';
use Game ':ALL';

my $game_player = Player::GamePlayer->new({
    first_name => 'Alvin',
    last_name  => 'Patrimonio',
    jersey     => '16',
    team       => 'Hotdogs',
});

my $game = Game->new({
        team1 => 'Misfits',
        team2 => 'Cybergilas',
        date  => '2014-03-15 08:00 PM',
});

isa_ok $game_player, 'Player::GamePlayer';
isa_ok $game_player, 'Player'; # base class check
can_ok $game_player, 'team';

can_ok $game_player, 'add_game';
throws_ok { $game_player->add_game(undef) }
    qr/game parameter is not a Game/,
    "add_game throws exception if game is not a game object";

can_ok $game_player, 'add_score_for';
can_ok $game_player, 'score_for';
throws_ok { $game_player->add_score_for($game_player) }
    qr/game parameter is not a Game/,
    "add_score_for throws exception if game is not a game object";

throws_ok { $game_player->add_score_for($game) }
    qr/gameplayer did not play in this game/,
    "add_score_for throws exception if game is not added into gameplayer";

is $game_player->add_game($game), '1', 'add_game returns 1 if first time to add game';



can_ok $game_player, 'total_score';

can_ok $game_player, 'average_points';

can_ok $game_player, 'games_played';

can_ok $game_player, 'fouls_for';

can_ok $game_player, 'total_fouls';

can_ok $game_player, 'average_fouls';

done_testing;
