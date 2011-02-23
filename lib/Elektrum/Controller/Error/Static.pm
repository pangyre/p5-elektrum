package Elektrum::Controller::Error::Static;
use Moose;
use Catalyst::Exception;
use HTTP::Status ();
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

sub process : Private {
    my ( $self, $c ) = @_;
    my $error = join("\n\n", @{$c->error});
    $c->log->error($error);
    $c->response->status(500);
    $c->response->content_type("text/plain");
    $c->response->body($error);
    $c->clear_errors;
    $c->detach("/render");
}

__PACKAGE__->meta->make_immutable;

1;

__END__
