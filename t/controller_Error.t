use ElekTest;
use strict;
use Elektrum::Controller::Error;

my @errors = ( 400 .. 417,
               422 .. 426,
               449,
               500 .. 507,
               509 .. 510,
             );

plan tests => 2 * @errors ;

SKIP: {
    my $ctx = [ ctx_request("/") ]->[1];
    skip "Throwing errors only works under debug",
        2 * @errors unless $ctx->debug;

    for my $error ( @errors )
    {
        my $path = "/error/throw/$error";
        my $response = request($path);

        is( $response->code, $error,
            "Response status $error for $path" );

        like( $response->decoded_content, qr/\b$error\b/,
              "Response body contains $error" );
    }
};

done_testing();

__END__

