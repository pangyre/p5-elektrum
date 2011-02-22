package Elektrum::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN { extends "Catalyst::Controller" }

sub base : Chained PathPart("user") CaptureArgs(0) { 
    my ( $self, $c ) = @_;
}

sub list : Chained("base") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body("OK");
}

sub with_id : Chained("base") PathPart("") CaptureArgs(1) {
    my ( $self, $c ) = @_;
}

sub single : Chained("with_id") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
}

__PACKAGE__->meta->make_immutable;

1;

__END__
