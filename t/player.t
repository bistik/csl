use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';

use Player ':ALL';


throws_ok {
    Player->new(
        {
            last_name => 'Jordan',
            jersey    => '23',
            team      => 'Bulls',
        }
        )
    }
    qr/first_name cannot be blank/,
    'Player throws exception if it doesn\'t have a first_name';

throws_ok {
    Player->new(
        { 
            last_name  => 'Jordan',
            first_name => '',
            jersey     => '23',
            team       => 'Bulls',
        }
        )
    }
    qr/first_name cannot be blank/,
    'Player throws exception if first_name is blank';

throws_ok {
    Player->new(
        {
            first_name => 'Michael',
            jersey     => '23',
            team       => 'Bulls',
        }
        )
    }
    qr/last_name cannot be blank/,
    'Player throws exception if it doesn\'t have a last_name';

throws_ok {
    Player->new(
        {
            first_name => 'Michael',
            last_name  => '',
            jersey     => '23',
            team       => 'Bulls',
        }
        )
    }
    qr/last_name cannot be blank/,
    'Player throws exception if last_name is blank';

throws_ok {
    Player->new(
        {
            first_name => 'Michael',
            last_name  => 'Jordan',
            team       => 'Bulls',
        }
        )
    }
    qr/jersey cannot be blank/,
    'Player throws exception if it doesn\'t have a jersey number';

throws_ok {
    Player->new(
        {
            first_name => 'Michael',
            last_name  => 'Jordan',
            jersey     => 'abc',
            team       => 'Bulls',
        }
        )
    }
    qr/jersey cannot be blank and must be a number/,
    'Player throws exception if jersey is not a number';

throws_ok {
    Player->new(
        {
            first_name => 'Michael',
            last_name  => 'Jordan',
            jersey     => '23',
            team       => 'Bulls',
            position   => 'coach',
        }
        )
    }
    qr/Invalid position/,
    'Player throws exception if position is not G or F';

throws_ok {
    Player->new(
        {
            first_name => 'Michael',
            last_name => 'Jordan',
            jersey => '23',
            team => 'Bulls',
            height => "6 feet 6 inches"
        }
        )
    }
    qr/Invalid attribute 'height'/,
    'Player does not accept extra attributes';

my $player = Player->new({
                first_name => 'Michael',
                last_name => 'Jordan',
                jersey => '23',
                team => 'Bulls',
                position => 'G',
            });

isa_ok $player, 'Player';
can_ok 'Player', qw/jersey name/;

is $player->jersey, '23', 'Jersey should match player->{jersey}';
is $player->name, 'Michael', 'Player name should match player->{first_name}';

can_ok 'Player', 'position';
is $player->position, 'G', 'Player position should match player->{position}';

$player = Player->new({
                first_name => 'Michael',
                last_name => 'Jordan',
                jersey => '23',
                team => 'Bulls',
            });

can_ok 'Player', 'position';
is $player->position, 'Unknown', 'Player position should be unknown if position is not set via new';

$player = Player->new({
                first_name => 'Michael',
                last_name => 'Jordan',
                jersey => '23',
                team => 'Bulls',
            });
can_ok 'Player', 'team';

done_testing;
