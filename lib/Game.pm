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

    foreach my $key ( qw/team1 team2 date time/ ) {
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

1;
