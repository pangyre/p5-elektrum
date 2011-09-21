#!/usr/bin/env perl
use warnings;
use strict;
our $lib;
BEGIN {
    use File::Spec;
    ( $lib = File::Spec->rel2abs(__FILE__) ) =~ s/app\.psgi/lib/;
}
use lib $lib;
use Elektrum;

my $app = Elektrum->psgi_app(@_);

__END__
