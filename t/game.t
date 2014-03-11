use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';
use Game ':ALL';

can_ok 'Game', 'new';

my $game = Game->new( {
        team1 => 'Misfits',
        team2 => 'Cybergilas',
        date  => '2014-03-15 08:00 PM',
    } );

can_ok 'Game', 'team1';
is $game->team1, 'Misfits', 'game should return team1 set via new';

can_ok 'Game', 'team2';
is $game->team2, 'Cybergilas', 'game should return team2 set via new';

can_ok 'Game', 'score';
my @score = $game->score;
my @expected = (0,0);
is_deeply \@score, \@expected, "game->score should be (@score)==(@expected) if game has not yet been played";

can_ok 'Game', 'winner';
is $game->winner, undef, 'game->winner should return false if score is 0-0';

can_ok 'Game', 'date';

can_ok 'Game', 'set_score';

$game->set_score( { team2 => 201 } );
@score = $game->score;
@expected = (0,201);
is_deeply \@score, \@expected, "game->score should be (@score) == (@expected) after game->set_score";

$game->set_score( { team1 => 100, team2 => 101 } );
@score = $game->score;
@expected = (100,101);
is_deeply \@score, \@expected, "game->score should be (@score) == (@expected) after game->set_score";

done_testing;
