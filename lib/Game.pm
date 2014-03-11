package Game;

use Carp 'croak';

sub new {
    my ($class, $arg_for) = @_;

    my $self = bless {} => $class;
    $self->_initialize( $arg_for );

    return $self;
}

sub _initialize {
    my ($self, $arg_for) = @_;
    my %arg_for = %$arg_for;

    foreach my $key ( qw/team1 team2 date/ ) {
        unless ($arg_for{$key}) {
            croak "$key is not defined";
        }
        $self->{$key} = delete $arg_for{$key};
    }

    $self->{score1} = 0;
    $self->{score2} = 0;
}

sub team1 { $_[0]->{team1} }
sub team2 { $_[0]->{team2} }
sub date { $_[0]->{date} }
sub score { return $_[0]->{score1}, $_[0]->{score2} }
sub winner { 
    my $self = shift;

    unless ( $self->{score1} and $self->{score2} ) {
        return undef;
    }
    if ( $self->{score1} == $self->{score2} ) {
        return undef; # no winner?
    }
    if ( $self->{score1} > $self->{score2} ) {
        return $self->{team1};
    } else {
        return $self->{team2};
    }
}

sub set_score {
    my ($self, $arg_for) = @_;
    my %arg_for = %$arg_for;

    foreach my $i ( 1, 2 ) {
        $self->{"score$i"} = 0 + $arg_for{"team$i"};    
    }
}

1;
