package Elektrum::Role::RS;
use Moose::Role;
requires qw( base );

has "rs" =>
    is => "ro",
    writer => "set_rs",
    ;

after "base" => sub {
    my ( $self, $c ) = @_;
    my $class = blessed($self);
    ( my $model = $class ) =~ s/\A.+::/DBIC::/; # E.g., Elektrum::Controller::Node
    ( my $isa = $class ) =~ s/Controller/Schema::ResultSet/;
#    die $model;
    $self->set_rs( $c->model($model) );
};

1;

__END__
