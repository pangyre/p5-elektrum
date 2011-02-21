package Elektrum::Controller::Node;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

has "rs" =>
    is => "rw",
    ;

sub base : Chained PathPart("n") CaptureArgs(0) { 
    my ( $self, $c ) = @_;
}

sub list : Chained("base") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body("OK");
}

sub with_id : Chained("base") PathPart("") CaptureArgs(1) {
    my ( $self, $c ) = @_;
}

sub single : Chained("item") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
}

sub atom : Chained("list") Args(0) {
    my ( $self, $c ) = @_;
}

sub atom_single : Chained("with_id") PathPart("atom") Args(0) {
    my ( $self, $c ) = @_;
}

__PACKAGE__->meta->make_immutable;

1;

__END__
