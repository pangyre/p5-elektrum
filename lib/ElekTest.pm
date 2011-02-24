use strict;
use Test::More;
use HTTP::Request::Common;
use File::Spec;

use Sub::Exporter -setup => {
    exports => [
        qw( BAIL_OUT GET POST ),
        ]
};

BEGIN { $ENV{ELEKTRUM_CONFIG_LOCAL_SUFFIX} ||= "test" }
use Catalyst::Test "Elektrum"; # { default_host => "" };

{
    my $ctx = [ ctx_request("/") ]->[1];
    $ctx->model("DBIC")->schema->deploy;
}

# Maybe not...
my $null = File::Spec->devnull();
open STDERR, '>', $null or die "Could not open '$null': $!";

1;

__END__

=pod

=head1 Synopsis

=cut
