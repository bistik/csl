use strict;
use warnings;

use Test::More;
use Test::Exception;
use lib 'lib';

use Player::CSVLoader;
use Cwd 'abs_path';
use File::Basename 'dirname';

can_ok 'Player::CSVLoader', 'new';
throws_ok { my $loader = Player::CSVLoader->new }
    qr/Missing attribute/,
    'CSVLoader must have an attribute';
throws_ok { my $loader = Player::CSVLoader->new({file=>''}) }
    qr/Missing file/,
    'CSVLoader must have a file attribute';

my $path = dirname(abs_path($0));
my $loader = Player::CSVLoader->new({ file => "$path/player_loader.csv" });

can_ok 'Player::CSVLoader', 'get_players';     # all players
can_ok 'Player::CSVLoader', 'get_players_for'; # players on a team
done_testing;
