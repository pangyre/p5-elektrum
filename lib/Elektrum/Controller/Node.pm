package Elektrum::Controller::Node;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched Elektrum::Controller::Node in Node.');
}

__PACKAGE__->meta->make_immutable;

1;

__END__
