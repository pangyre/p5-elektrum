package Elektrum;
use 5.12.2;
use Moose;
use namespace::autoclean;
our $VERSION = "0.01";

use Catalyst::Runtime 5.80;

use Catalyst qw(
    Unicode::Encoding
    ConfigLoader
    Static::Simple
    Authentication
    Session
    Session::Store::FastMmap
    Session::State::Cookie
);

extends "Catalyst";

has "theme" =>
    is => "rw",
    isa => "Str", # for now
    required => 1,
    default => sub { "Default" }
    ;

has "site" =>
    is => "rw",
    isa => "HashRef", # for now
    required => 1,
    lazy => 1,
    default => sub { +shift->config->{site} }
    ;

__PACKAGE__->config(
    name => "Elektrum",
    disable_component_resolution_regex_fallback => 1,
    # "Plugin::Static::Simple"... 4 years later...
    static => {
        include_path => [ __PACKAGE__->path_to('root', 'static') ],
        ignore_extensions => [],
        debug => 0,
        mime_types => {
            svg => "image/svg+xml",
            html => "text/html",
            jsn => "application/json",
        },
    },
    "Plugin::Authentication" => {
        default_realm => "openid",
        realms => {
            openid => {
                credential => {
                    class => "OpenID",
                    store => {
                        class => "OpenID",
                    },
                    # consumer_secret => "Don't bother setting",
                    ua_class => "LWPx::ParanoidAgent",
                    # whitelist is only relevant for LWPx::ParanoidAgent
                    ua_args => {
                        whitelisted_hosts => [qw/ 127.0.0.1 localhost /],
                    },
                    extensions => [
                        'http://openid.net/extensions/sreg/1.1',
                        {
                            required => 'email',
                            optional => 'fullname,nickname,timezone',
                        },
                        ],
                    flatten_extensions_into_user => 1,
                },
            },
        },
    },
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
