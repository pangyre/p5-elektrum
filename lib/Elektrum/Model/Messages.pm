package Elektrum::Model::Messages;
use Moose;
use HTTP::Status;
use namespace::autoclean;
extends "Catalyst::Model";

__PACKAGE__->config(
    # schema_class => "Elektrum::Schema",
    );

sub status2en {
    my ( $self, $msg ) = @_;
    $msg;
}

1;

__END__

I have no idea if this is where I want to do this. Templates might be
more appropriate. Probably are. Just stubbing it out as it occurs to me.
