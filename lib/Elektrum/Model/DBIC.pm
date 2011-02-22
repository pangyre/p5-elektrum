package Elektrum::Model::DBIC;
use strict;
use parent "Catalyst::Model::DBIC::Schema";

__PACKAGE__->config(
    schema_class => "Elektrum::Schema",
    );

1;

__END__

=head1 NAME

Elektrum::Model::DBIC - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<Elektrum>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<Elektrum::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.48

=head1 AUTHOR

apv

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
