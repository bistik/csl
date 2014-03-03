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
        print "attr: $attr\n";
        unless ( $arg_for{$attr} ) {
            croak "$attr cannot be blank";
        }
    }
    my $jersey = $arg_for{jersey};
    unless ( $jersey && $jersey =~ /\d/ ) {
        croak "jersey cannot be blank and must be a number";
    }
}

1;
