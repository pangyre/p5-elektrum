package Elektrum::Role::RS;
use Moose::Role;
requires qw( base );

has "rs" =>
    is => "ro",
    writer => "set_rs",
    ;

has "model" =>
    is => "ro",
    writer => "set_model",
    ;

after "base" => sub {
    my ( $self, $c ) = @_;
    my $class = blessed($self);
    ( my $model = $class ) =~ s/\A.+::/DBIC::/; # E.g., Elektrum::Controller::Node
    ( my $isa = $class ) =~ s/Controller/Schema::ResultSet/;
#    die $model;
    $self->set_rs( $c->model($model)->search );
    $self->set_model( $c->model($model) );
};

1;

__END__
