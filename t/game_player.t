use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';

use Player::GamePlayer ':ALL';
use Game ':ALL';

my $game_player = Player::GamePlayer->new({
    first_name => 'Sonny',
    last_name  => 'Jaworski',
    jersey     => '16',
    team       => 'Misfits',
});

my $alien_game_player = Player::GamePlayer->new({
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

my $game2 = Game->new({
        team1 => 'Misfits',
        team2 => 'Cyberstars',
        date  => '2014-03-15 09:00 PM',
});

isa_ok $game_player, 'Player::GamePlayer';
isa_ok $game_player, 'Player'; # base class check
can_ok $game_player, 'team';

can_ok $game_player, 'add_game';
throws_ok { $game_player->add_game(undef) }
    qr/game parameter is not a Game/,
    "add_game throws exception if game is not a game object";

can_ok $game_player, 'add_score_for';
throws_ok { $game_player->add_score_for($game_player) }
    qr/game parameter is not a Game/,
    "add_score_for throws exception if game is not a game object";

throws_ok { $game_player->add_score_for($game) }
    qr/gameplayer did not play in this game/,
    "add_score_for throws exception if game is not added into gameplayer";

throws_ok { $alien_game_player->add_game($game) }
    qr/player team is not part of this game/,
    'add_game throws exception if player team is not in the game';

is $game_player->add_game($game), 1, 'add_game returns 1 if first time to add game';
is $game_player->add_score_for($game, 20), 20, 'add_score_for->points and points param should match';

can_ok $game_player, 'score_for';
is $game_player->score_for($game), 20, 'score_for should match points added via add_score_for';

can_ok $game_player, 'total_score';
is $game_player->total_score, 20, 'total_score should add all scores';
$game_player->add_game($game2);
$game_player->add_score_for($game2, 12);
is $game_player->total_score, 32, 'total_score should add all scores';

can_ok $game_player, 'average_points';
is $game_player->average_points, 32/2, 'average_points should return correct average';

can_ok $game_player, 'games_played';
is $game_player->games_played, 2, 'games_played should match unique games added';

can_ok $game_player, 'add_fouls_for';

can_ok $game_player, 'fouls_for';

can_ok $game_player, 'total_fouls';

can_ok $game_player, 'average_fouls';

done_testing;
