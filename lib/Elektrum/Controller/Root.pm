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
    $c->go("Error", [404]);
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

    # If there was an error in the render above, process it and re-render.
    if ( @{$c->error} )
    {
        $c->forward("Error") and $c->forward("render");
    }

    # If there is a new error at this point, it's time to redirect to
    # a static page or do something terribly simple...
    if ( @{$c->error} )
    {
        $c->detach("Error::Static");
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
