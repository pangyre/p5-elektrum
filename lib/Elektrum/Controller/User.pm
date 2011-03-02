package Elektrum::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN { extends "Catalyst::Controller" }

sub base : Chained PathPart("user") CaptureArgs(0) { 
    my ( $self, $c ) = @_;
}

sub list : Chained("base") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
}

sub id : Chained("base") PathPart("") CaptureArgs(1) {
    my ( $self, $c ) = @_;
}

sub view : Chained("id") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
}

sub register : Local Args(0) {
    my ( $self, $c ) = @_;
}

sub confirm : Local Args(1) {
    my ( $self, $c, $token ) = @_;

}

__PACKAGE__->meta->make_immutable;

1;

__END__
