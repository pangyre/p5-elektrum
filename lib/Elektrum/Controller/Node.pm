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

sub with_id : Chained("base") PathPart("") CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $node = $self->rs->find($id)
        or $c->detach("Error", [404]);
}

sub single_view : Chained("with_id") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => "node/view_single.tt" );
}

sub edit : Chained("with_id") Args(0) {
    my ( $self, $c ) = @_;
}

sub revisions : Chained("with_id") PathPart("rev") Args(0) {
    my ( $self, $c ) = @_;
}

sub rev : Chained("with_id") Args(1) {
    my ( $self, $c, $id ) = @_;
}

sub single_atom : Chained("with_id") PathPart("atom") Args(0) {
    my ( $self, $c ) = @_;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

chain_point "_base"
    => chained "/"
    => path_part "n"
    => capture_args 0
    => sub {
        my ( $self, $c, $id ) = @_;
        $self->rs( $c->model("DBIC::Node")->search_rs );
};

chain_point "_set_node"
    => chained "_base"
    => path_part ""
    => capture_args 1
    => sub {
        my ( $self, $c, $id ) = @_;
};

get ""
    => chained("_set_node")
    => args 0
    => sub {
        my ( $self, $c, $id ) = @_;

        $c->stash( template => "node/view.tt",
                   node => $self->rs->find($id),
                 );
};

get ""
    => chained("_base")
    => args 0
    => sub {
        my ( $self, $c, $id ) = @_;
        $c->response->body("OK");
};


get "atom"
    => chained("_base")
    => args 0
    => sub {
        my ( $self, $c, $id ) = @_;
        $c->response->body("OK");
};

get "edit"
    => chained("_set_node")
    => args 0
    => sub {
        my ( $self, $c ) = @_;
};

get "rev"
    => chained("_set_node")
    => args 1
    => sub {
        my ( $self, $c, $rev ) = @_;
};

get "atom"
    => chained("_set_node")
    => args 0
    => sub {
        my ( $self, $c, $id ) = @_;
};
