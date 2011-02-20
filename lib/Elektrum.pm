package Elektrum;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw(
    -Debug
    ConfigLoader
    Static::Simple
);

extends 'Catalyst';

our $VERSION = '0.01';

__PACKAGE__->config(
    name => 'Elektrum',
    disable_component_resolution_regex_fallback => 1,
);

__PACKAGE__->setup();

1;

__END__

=head1 NAME

Elektrum - Catalyst based application

=head1 SYNOPSIS

    script/elektrum_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Elektrum::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Ashley Pond V.

=head1 LICENSE

This library is free software. You can redistribute, modify
it, or both under the same terms as Perl itself.

=cut
