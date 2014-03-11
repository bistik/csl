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

TODO: {
local $TODO = 'game knows which teams are competing';
can_ok 'Game', 'team1';
is $game->team1, 'Misfits', 'game should return team1 set via new';

can_ok 'Game', 'team2';
is $game->team2, 'Cybergilas', 'game should return team2 set via new';

local $TODO = 'game knows the score';
can_ok 'Game', 'score';
is $game->score, '0-0', 'game->score should be 0-0 if game has not yet been
played';

local $TODO = 'game knows who won';
can_ok 'Game', 'winner';
is $game->winner, undef, 'game->winner should return false if score is 0-0';

local $TODO = 'game knows its date & time';
can_ok 'Game', 'date';
}

done_testing;
