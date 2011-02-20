package Elektrum::Schema::Defaults;
use strict;
use warnings;
use parent "DBIx::Class::Core";

sub TO_JSON { return { +shift->get_columns } }

1;

__END__
