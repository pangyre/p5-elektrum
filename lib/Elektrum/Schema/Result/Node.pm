package Eleketurm::Schema::Result::Node;
use warnings;
use strict;
use parent "DBIx::Class::Core";

__PACKAGE__->load_components(qw( Tree::Mobius ));

__PACKAGE__->table("node");

__PACKAGE__->add_columns(
    id => {
        data_type => "integer",
        default_value => undef,
        extra => { unsigned => 1 },
        is_auto_increment => 1,
        is_nullable => 0,
        size => 10,
    },
    );


__PACKAGE__->add_columns(
    mobius_a => { data_type => "integer", 
                  extra => { unsigned => 1 },
                  is_nullable => 1,
                  size => 11 },
    mobius_b => { data_type => "integer",
                    extra => { unsigned => 1 },
                    is_nullable => 1,
                    size => 11 },
    mobius_c => { data_type => "integer",
                  extra => { unsigned => 1 },
                  is_nullable => 1,
                  size => 11 },
    mobius_d => { data_type => "integer",
                  extra => { unsigned => 1 },
                  is_nullable => 1,
                  size => 11 },
    lft => { data_type => "float",
             extra => { unsigned => 1 },
             default_value => 1,
             is_nullable => 0 },
    rgt =>{ data_type => "float",
            extra => { unsigned => 1 },
            is_nullable => 1 },
    inner => { data_type => "boolean",
               default_value => 0,
               is_nullable => 0 },
    );

__PACKAGE__->add_mobius_tree_columns();

1;

__END__

=head1 NAME

=head1 ACCESSORS

=head2 id

  data_type: "integer"
  is_nullable: 0
  size: 11

=head2 name

  data_type: "text"
  is_nullable: 0

=head2 bodytext

  data_type: (empty string)
  is_nullable: 0

=head2 mobius_a

  data_type: "integer"
  is_nullable: 1
  size: 11

=head2 mobius_b

  data_type: "integer"
  is_nullable: 1
  size: 11

=head2 mobius_c

  data_type: "integer"
  is_nullable: 1
  size: 11

=head2 mobius_d

  data_type: "integer"
  is_nullable: 1
  size: 11

=head2 lft

  data_type: "float"
  default_value: 1
  is_nullable: 0

=head2 rgt

  data_type: "float"
  is_nullable: 1

=head2 inner

  data_type: "boolean"
  default_value: 0
  is_nullable: 0

=cut
