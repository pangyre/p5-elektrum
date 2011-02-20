#!/usr/bin/env perl
use strict;
use warnings;
use Elektrum;

Elektrum->setup_engine('PSGI');
my $app = sub { Elektrum->run(@_) };

