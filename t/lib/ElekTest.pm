use strict;
use warnings;
use Test::More;

BEGIN { $ENV{ELEKTRUM_CONFIG_LOCAL_SUFFIX} ||= "test" }
use Catalyst::Test "Elektrum"; # { default_host => "" };
use HTTP::Request::Common;

{
    my $ctx = [ ctx_request("/") ]->[1];
    $ctx->model("DBIC")->schema->deploy;
}

1;

__END__


=pod

=head1 Synopsis

=cut
