package Elektrum::Controller::Root;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

__PACKAGE__->config(namespace => "");

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body("O HAI");
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( "Page not found" );
    $c->response->status(404);
}


sub render : ActionClass("RenderView") {}

sub end : Private {
    my ( $self, $c ) = @_;
    $c->forward("render") unless @{$c->error};
    if ( grep /no such table/, @{$c->error} )
    {
        $c->log->error("Apparently there is no database, attempting auto deployment");
        $c->model("DBIC")->schema->deploy();
        $c->clear_errors;
        $c->forward("render");
    }

}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Elektrum::Controller::Root - Root Controller for Elektrum

=head1 DESCRIPTION

[enter your description here]

=cut
