#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Fatal;

BEGIN { use_ok("Elektrum::Schema") }

ok( my $schema = Elektrum::Schema->connect("dbi:SQLite::memory:"),
    "Connecting to :memory:"
    );

ok( ! exception { $schema->deploy },
    "Deploy doesn't cause an exception" );

done_testing();
