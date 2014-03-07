package Tournament;

use strict;
use warnings;

use Carp 'croak';
use Try::Tiny;

sub new {
    my ($class, $arg_for) = @_;
    my $self = bless {} => $class;

    $self->_initialize($arg_for);

    return $self;
}

sub _initialize {
    my ($self, $arg_for) = @_;

    my %arg_for = %$arg_for;
    my $teams_ref = delete $arg_for{teams};
    $self->{teams} = $teams_ref;
    
    foreach my $extra_attr ( keys %arg_for ) {
        croak "Invalid attribute '$extra_attr'";
    }
}

sub teams { $_[0]->{teams} }
sub team_exists { 
    my ($self, $team) = @_;
    my @tournament_teams = @{ $self->teams };
    return grep { $_ eq $team } @tournament_teams;
}

sub add_player {
    my ($self, $player) = @_;
    
    unless ($player) {
        croak "Missing player argument for add_player";
    }
    try {
        unless ($player->isa('Player::GamePlayer')) {
            croak "Argument for add_player must be of type Player::GamePlayer";
        }
    } catch {
        croak "Argument for add_player must be of type Player::GamePlayer $!";
    };

    push @{ $self->{players} }, $player;
}

1;
