#!/usr/bin/env perl
use warnings;
use strict;
use Test::More;
use File::Temp qw( tempdir );
use Capture::Tiny qw( capture_merged tee );
use App::Prove;

my $dir = tempdir( CLEANUP => 1 );
ok( -d $dir, "Temp build dir" );
ok( chdir $dir, "chdir $dir" );

{
#    note( my $clone = capture_merged { system qw( git clone git@github.com:pangyre/p5-elektrum.git ) } );
#    like( $clone, qr/Initialized empty Git repository/ );
#    my $app_dir = "p5-elektrum";
    my $app_dir = "/Users/apv/depot/p5-elektrum";
    ok( chdir $app_dir, "chdir $app_dir" );
}

my @smoke_args = qw( -l t/ -r );
push @smoke_args, "-v" if $ENV{TEST_VERBOSE};

{
    diag("Running application tests --------------------------");
    my $app = App::Prove->new;
    $app->process_args( @smoke_args );
    #$app->process_args(qw( -l t/db-deploy-test.t ));
    my $result = $app->run;
    diag("Done with application tests ------------------------");

    $result ?
        pass("Application tests PASS") : fail("Application tests FAIL");
}

ok( chdir, "chdir for safe cleanup of tempdir" );

done_testing();

exit 0;

#  Subroutines
#---------------------------------------------------------------------

__DATA__
