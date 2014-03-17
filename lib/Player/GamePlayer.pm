package Player::GamePlayer;

use strict;
use warnings;
use Try::Tiny;
use Carp 'croak';

use base 'Player';

sub score_for {
   my ($self, $game) = @_; 
}

sub add_score_for {
    my ($self, $game) = @_;

    $self->_check_game($game);
    $self->_check_game_exists($game);
}

sub _check_game {
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

sub add_game {
    my ($self, $game) = @_;

    $self->_check_game($game);
    my $game_id = $game->date;

    unless ( exists $self->{games}{$game->date} ) {
        $self->{games}{$game->date} = undef;
        return 1;
    }
    return 0;
}

1;
