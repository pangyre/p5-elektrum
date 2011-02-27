#!/usr/bin/env perl
use warnings;
use strict;
use File::Temp qw( tempdir );
use Capture::Tiny qw( capture_merged tee );
use App::Prove;

my $dir = tempdir( CLEANUP => 1 );
-d $dir or die "Temp build dir created";
chdir $dir or die "Couldn't chdir $dir";

#    my $clone = capture_merged { system qw( git clone git://github.com/pangyre/p5-elektrum.git ) };
#    $clone =~ qr/Initialized empty Git repository/
#        or die "Git repo failed: $clone";
#    my $app_dir = "p5-elektrum";
my $app_dir = "/Users/apv/depot/p5-elektrum";
chdir $app_dir or die "Couldn't chdir $app_dir";

my @smoke_args = qw( -l t/ -r );
push @smoke_args, "-v" if $ENV{TEST_VERBOSE};

# Not yet, local $ENV{TEST_POD} = 1;

my $app = App::Prove->new;
$app->process_args( @smoke_args );
my $result = $app->run;

chdir or warn "Couldn't chdir for safe cleanup of tempdir\n";

exit 0;

__DATA__

=pod

=head1 ...

  env TEST_VERBOSE=1 perl -Ilib SMOKE.pl

=cut
