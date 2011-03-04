package Elektrum::Controller::User;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }
# BEGIN { extends "Catalyst::Controller::HTML::FormFu" }
with "Elektrum::Role::RS";

sub base : Chained PathPart("user") CaptureArgs(0) { 
    my ( $self, $c ) = @_;
}

sub list : Chained("base") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
}

sub id : Chained("base") PathPart("") CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $user = $c->model("DBIC::User")->find($id)
        or $c->detach("/not_found");
    $c->stash( user => $user );
}

sub view : Chained("id") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
}

sub login : Local Args(0) {
    my ( $self, $c ) = @_;
    if ( $c->authenticate() )
    {
        $c->flash(message => "You signed in with OpenID!");
#        $c->response->redirect($c->uri_for("/"));
    }

}

sub logout : Local Args(0) {
    my ( $self, $c ) = @_;
    # Maybe only operate on POST, yeah? Give a form otherwise?

    $c->delete_session("User logout") if $c->user_exists;

    # Set message.
    # Redirect to referer if wise.
}

#sub confirm : Local Args(1) {
#    my ( $self, $c, $token ) = @_;
#}

__PACKAGE__->meta->make_immutable;

1;

__END__
