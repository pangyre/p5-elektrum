package Elektrum::Controller::Node;
use Moose;
use CatalystX::Routes;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

has "rs" =>
    is => "rw",
    ;

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

get ""
    => chained("_set_node")
    => args 0
    => sub {
        my ( $self, $c, $id ) = @_;
};

get "edit"
    => chained("_set_node")
    => args 0
    => sub {
        my ( $self, $c, $id ) = @_;
};

get "atom"
    => chained("_set_node")
    => args 0
    => sub {
        my ( $self, $c, $id ) = @_;
};

__PACKAGE__->meta->make_immutable;

1;

__END__
