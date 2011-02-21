package Elektrum::Schema::Defaults;
use warnings;
use strict;
use parent "DBIx::Class";

sub TO_JSON { return { +shift->get_columns } }

1;

__END__
