package Player::CSVLoader;

use strict;
use warnings;

use Carp 'croak';
use Text::CSV;

use lib 'lib';
use Player::GamePlayer;

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
    open my $fh, '<', $self->{file} or die "Error reading $self->{file} : $!";
    
    my $csv = Text::CSV->new({
        binary    => 1,
        auto_diag => 1,
    });

    my @header = map { $self->_normalize($_) } @{ $csv->getline($fh) };

    while (my $row = $csv->getline($fh)) {
        my %player;
        @player{@header} = map { $self->_trim($_) } @$row;

        my @invalid_keys;

        foreach my $key ( keys %player ) {
            delete $player{$key}
                if $key !~ /jersey|last_name|first_name|team/;
        }

        push @{ $self->{players} } => Player::GamePlayer->new(\%player);
    }
}

# trim, lowercase and replace spaces
sub _normalize {
    my ($self, $str) = @_;

    $str = lc $self->_trim($str);
    $str =~ tr/ /_/;
    return $str;
}

sub _trim {
    my ($self, $str) = @_;

    $str =~ s/^\s+//;
    $str =~ s/\s+$//;

    return $str;
}

1;
