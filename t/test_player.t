use strict;
use warnings;

use Test::More;
use Test::Exception;

use lib 'lib';

use Player ':ALL';


throws_ok { Player->new( { last_name => 'Jordan' } ) }
        qr/first_name cannot be blank/,
        'Player should have a first_name';

throws_ok { Player->new( { last_name => 'Jordan', first_name => '' } ) }
        qr/first_name cannot be blank/,
        'Player should have a first_name';

throws_ok { Player->new( { first_name => 'Michael' } ) }
        qr/last_name cannot be blank/,
        'Player should have a last_name';

throws_ok { Player->new( { first_name => 'Michael', last_name => '' } ) }
        qr/last_name cannot be blank/,
        'Player should have a last_name';

throws_ok { Player->new( { first_name => 'Michael', last_name => 'Jordan' } ) }
        qr/jersey cannot be blank/,
        'Player should have a jersey';

throws_ok { Player->new( { first_name => 'Michael', last_name => 'Jordan',
jersey => 'abc' } ) }
        qr/jersey cannot be blank and must be a number/,
        'Player jersey must be a number';

# my $player = Player->new();
done_testing;
