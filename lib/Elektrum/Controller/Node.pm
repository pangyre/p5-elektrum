package Elektrum::Controller::Node;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

has "rs" =>
    isa => "Elektrum::Schema::ResultSet::Node",
    is => "rw",
    ;

sub base : Chained("/") PathPart("n") CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $self->rs( $c->model("DBIC::Node")->search_rs );
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

sub single_view : Chained("id") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => "node/view_single.tt" );
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

sub random : Chained("tag") Args(0) {
    my ( $self, $c, $tags ) = @_;
}

__PACKAGE__->meta->make_immutable;

1;

__END__
