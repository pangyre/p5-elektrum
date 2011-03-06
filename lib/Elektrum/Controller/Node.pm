package Elektrum::Controller::Node;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller::HTML::FormFu" }
with "Elektrum::Role::RS";

sub base : Chained("/") PathPart("n") CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub list : Chained("base") PathPart("") CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub index : Chained("list") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => "node/index.tt" );
}

sub atom : Chained("list") Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => "node/index.tt" );
}

sub id : Chained("base") PathPart("") CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $node = $self->rs->find($id)
        or $c->detach("Error", [404]);
}

sub single : Chained("id") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => "node/view_single.tt" );
}

sub new_node : Chained("base") PathPart("new") Args(0) FormConfig {
    my ( $self, $c ) = @_;
    my $node = $self->rs->new({});
    $c->stash( node => $node );
}

sub edit : Chained("id") Args(0) {
    my ( $self, $c ) = @_;
}

sub revisions : Chained("id") PathPart("rev") Args(0) {
    my ( $self, $c ) = @_;
}

sub rev : Chained("id") Args(1) {
    my ( $self, $c, $id ) = @_;
}

sub single_atom : Chained("id") PathPart("atom") Args(0) {
    my ( $self, $c ) = @_;
}

sub tag : Chained("base") CaptureArgs(1) {
    my ( $self, $c, $tags ) = @_;
    my @tags = split ";", $tags; # I think, yes.
}

sub tag_view : PathPart("") Chained("tag") Args(0) {
    my ( $self, $c ) = @_;
}

sub random : Chained("base") Args(0) {
    my ( $self, $c ) = @_;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

Look at https://github.com/pangyre/p5-ftl/blob/master/lib/FTL/Controller/Scritto.pm
