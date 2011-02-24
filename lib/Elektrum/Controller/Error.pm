package Elektrum::Controller::Error;
use Moose;
use Catalyst::Exception;
use HTTP::Status ();
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

sub process : Private {
    my ( $self, $c, $status, $error ) = @_;
    $status ||= 500;
    # confess $status;
    if ( $status < 300 ) # That's not an error and that's an error... What?
    {
        $c->log->debug("Error received a non-error status of $status, that's a 500 round these parts");
        $status = 500;
    }

    my $message = HTTP::Status::status_message($status)
        or die "Invalid status code '$status'";

    $c->response->status($status);

    $error ||= @{$c->error} ? 
        join("\n\n", @{$c->error}) : $@ ?
        $@ : $c->model("Messages")->status2en($message);

 # join(" ", "Unknown error caught by " . __PACKAGE__);

    my %info = ( status => $status,
                 message => $message,
                 title => join(": ", $status, $message),
                 error => $error );

    my $accept = $c->request->headers->header("accept");

    $c->log->error($error);
    $c->clear_errors;

    if ( $accept and $accept =~ m,application/json, )
    {
        $c->response->content_type("application/json");
        $c->response->status(200);
        $c->stash( json => \%info );
        $c->forward($c->view("JSON"));
    }
    elsif ( $accept and
            $accept =~ m,(?:application|text)/xml,
            and $accept !~ m,text/html, )
    {
        my ( $source, $line ) = $error =~ /\ACaught exception in (\S+).+?line (\d+)[[:punct:]]+/s;
        $c->response->content_type("application/xml");
        $c->response->status(200);
        $c->stash( %info,
                   template => "error/xml.tt",
                   line => $line,
                   source => $source,
            );
    }
    else
    {
        $c->response->content_type("text/html");
        $c->stash( template => "error/process.tt",
                   %info );
    }
    1;
}

sub throw : Local Args(1) {
    my ( $self, $c, $status ) = @_;   
    if ( $c->debug or $c->user_exists ) # and role ... )
    {
        eval {
            my $message = HTTP::Status::status_message($status)
                or $c->log->warn("Invalid status code '$status'");
            Catalyst::Exception->throw("$status: $message - manually thrown error for testing.");
            die "Catalyst::Exception->throw failed to cause exception!?";
        };
        $c->error($@);
        $c->detach("Error", [$status]);
    }
    else
    {
        $c->detach("Error", [404]);
    }
}

sub _status2en {
    my $self = shift;

}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=head1 NAME

Elektrum::Controller::Error

=head1 DESCRIPTION

Is used in conjunciton with L<Elektrum::Controller::Root>'s C<end> and C<render> methods to handle exceptions or allow manually set error statuses to be propagated.

=over 4

=item process

Allows the package to catch forwards and such without a named action. E.g.-

 $c->detach("Error", [403]);

Will execute C<< Error->process($c, $status, $error_text) >> and detach presenting a generic 403 Forbidden page.

The error pages can be customized per status by creating or edting a template to match. E.g.-

 root/tt2/error/403.tt

=item throw/[status]

For manually testing errors. It will 404 unless running under debug or requested by the migadmin user.

=back

=cut
