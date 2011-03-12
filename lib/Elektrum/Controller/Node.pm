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
    if ( $c->request->method eq "POST" )
    {
        $c->detach("create");
    }
    $c->stash( template => "node/index.tt" );
}

sub create : Private {
    my ( $self, $c ) = @_;
}

sub atom : Chained("list") Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => "node/index.tt" );
}

sub id : Chained("base") PathPart("") CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash->{node} = $self->model->find($id)
        or $c->detach("Error", [404]);
}

sub single : Chained("id") PathPart("") Args(0) {
    my ( $self, $c ) = @_;
#    $c->stash( template => "node/single.tt" );
}

sub new_node : Chained("base") PathPart("new") Args(0) FormConfig {
    my ( $self, $c ) = @_;
    my $form = $c->stash->{form};
    my $node = $self->model->new({});
    $form->constraints_from_dbic($self->model);
    $form->model->default_values($node);
#     $c->stash( node => $node );

    if ( $form->submitted_and_valid )
    {
        my $guard = $self->txn_scope_guard;        
        $form->model->update( $node );
        $guard->commit;
        $node->discard_changes;
        $c->response->redirect( $c->uri_for_action("node/single", [$node->id]) );
    }
}

sub edit : Chained("id") Args(0) FormConfig {
    my ( $self, $c ) = @_;
    my $form = $c->stash->{form};
    my $node = $c->stash->{node};
    $form->constraints_from_dbic($self->model);
    $form->model->default_values($node);
    if ( $form->submitted_and_valid )
    {
        my $guard = $self->txn_scope_guard;        
        $form->model->update( $node );
        $guard->commit;
        $c->response->redirect( $c->uri_for_action("node/single", [$node->id]) );
    }
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
