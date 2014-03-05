package Player;

use strict;
use warnings;
use Carp 'croak';

sub new {
    my ($class, $arg_for) = @_;
    my $self = bless {} => $class;

    $self->_initialize($arg_for);
    return $self;
}

sub _initialize {
    my ($self, $arg_for) = @_;
    my %arg_for = %$arg_for;


    foreach my $attr ( qw/last_name first_name team/ ) {
        unless ( $arg_for{$attr} ) {
            croak "$attr cannot be blank";
        }
        $self->{$attr} = delete $arg_for{$attr};
    }
    my $jersey = delete $arg_for{jersey} if $arg_for{jersey};
    unless ( $jersey && $jersey =~ /\d/ ) {
        croak "jersey cannot be blank and must be a number";
    }
    $self->{jersey} = $jersey;

    if ( $arg_for{position} ) {
        my $position = delete $arg_for{position};
        croak "Invalid position" unless $position =~ /g|f/i;
        $self->{position} = $position;
    }

    foreach my $extra_attr ( keys %arg_for ) {
        croak "Invalid attribute '$extra_attr'";
    }
}

sub jersey { $_[0]->{jersey} }
sub name { $_[0]->{first_name} }
sub position { $_[0]->{position} || 'Unknown' }

1;
