package Elektrum::Controller::Node::Search;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

__PACKAGE__->config(namespace => "n");

sub search : Local Args(0) {
    my ( $self, $c ) = @_;
    ...;
}

__PACKAGE__->meta->make_immutable;

1;

__END__
