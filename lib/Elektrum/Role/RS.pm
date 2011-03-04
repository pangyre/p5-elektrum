package Elektrum::Role::RS;
use Moose::Role;
requires qw( base );

after "base" => sub {
    my ( $self, $c ) = @_;
    my $class = blessed($self);
    ( my $model = $class ) =~ s/\A.+://; # E.g., Elektrum::Controller::Node
    ( my $isa = $class ) =~ s/Controller/Schema::ResultSet/;
    has "rs" =>
        is => "ro",
        isa => $isa,
        required => 1,
        init_arg => undef,
        default => sub { $c->model($model)->search }
        ;
};

1;

__END__
