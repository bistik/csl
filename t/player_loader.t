use strict;
use warnings;

use Test::More;
use Test::Exception;
use lib 'lib';

use Player::CSVLoader;

can_ok 'Player::CSVLoader', 'new';
throws_ok { my $loader = Player::CSVLoader->new }
    qr/Missing attribute/,
    'CSVLoader must have an attribute';
throws_ok { my $loader = Player::CSVLoader->new({file=>''}) }
    qr/Missing file/,
    'CSVLoader must have a file attribute';

can_ok 'Player::CSVLoader', 'get_players';     # all players
can_ok 'Player::CSVLoader', 'get_players_for'; # players on a team
done_testing;
