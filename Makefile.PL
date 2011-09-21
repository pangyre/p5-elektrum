#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst;

name "Elektrum";
all_from "lib/Elektrum.pm";

requires "Catalyst::Runtime" => "5.9";
requires "Catalyst::Plugin::ConfigLoader";
requires "Catalyst::Plugin::Static::Simple";
requires "Catalyst::Action::RenderView";
requires "Moose";
requires "namespace::autoclean";
test_requires "Test::More" => "0.88";
catalyst;

install_script glob("script/*.pl");
auto_install;
WriteAll;

__END__
