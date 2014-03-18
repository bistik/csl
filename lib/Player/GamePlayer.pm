package Player::GamePlayer;

use strict;
use warnings;
use Try::Tiny;
use Carp 'croak';
use List::Util 'sum';

use base 'Player';

sub score_for {
    my ($self, $game) = @_; 

    $self->_check_game_object($game);
    $self->_check_game_exists($game);

    return $self->{scores}{$game->date};
}

sub average_points {
    my $self = shift;

    my $total = sum values $self->{scores};
    return $total / $self->games_played;
}

sub games_played { scalar keys $_[0]->{games} }

sub add_score_for {
    my ($self, $game, $points) = @_;

    $self->_check_game_object($game);
    $self->_check_game_exists($game);
    $self->{scores}{$game->date} = $points;
}

sub total_score {
    my $self = shift;
    my $total = 0;

    foreach my $game_date (keys $self->{games}) {
        $total += $self->{scores}{$game_date};
    }

    return $total;
}

sub _check_game_object {
    my ($self, $game) = @_;

    try {
        $game->isa('Game') or die;
    } catch {
        croak "game parameter is not a Game object";
    };
}

sub _check_game_exists {
    my ($self, $game) = @_;

    unless( exists $self->{games}{$game->date}  ) {
        croak "gameplayer did not play in this game";
    } else {
        return $game->date;
    }
}

sub _check_player_team_in_game {
    my ($self, $game) = @_;

    unless ($self->team eq $game->team1 or $self->team eq $game->team2) {
        croak "player team is not part of this game";
    }
}

sub add_game {
    my ($self, $game) = @_;

    $self->_check_game_object($game);
    $self->_check_player_team_in_game($game);

    # maybe just use array? instead of games hash
    unless ( exists $self->{games}{$game->date} ) {
        return $self->{games}{$game->date} = 1;
    }
    return 0;
}

1;
