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


    foreach my $attr ( qw/last_name first_name/ ) {
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

    foreach my $extra_attr ( keys %arg_for ) {
        croak "Invalid attribute '$extra_attr'";
    }
}

1;
