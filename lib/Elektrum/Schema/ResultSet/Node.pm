package Elektrum::Schema::ResultSet::Node;
use warnings;
use strict;
use parent "DBIx::Class::ResultSet";

sub root {
    my $self = shift;
    my $source = $self->result_class;
    $self->search($source->root_cond);
}

sub root_rs {
    scalar +shift->root;
}

1;

__END__
