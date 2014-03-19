package Player::CSVLoader;

use strict;
use warnings;

use Carp 'croak';

sub new {
    my ($class, $arg_for) = @_;

    croak "Missing attributes for Player::CSVLoader" unless $arg_for;

    my $self = bless {} => $class;
    $self->_initialize($arg_for);
    $self->_load_csv;

    return $self;
}

sub _initialize {
    my ($self, $arg_for) = @_;
    my %arg_for = %$arg_for;

    unless ($arg_for{file}) {
        croak "Missing file parameter for Player::CSVLoader"
    }
    $self->{file} = delete $arg_for{file};
}

sub _load_csv {
    my $self = shift;

}
1;
