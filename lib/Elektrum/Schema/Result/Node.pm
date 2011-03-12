package Elektrum::Schema::Result::Node;
use warnings;
use strict;
use parent "DBIx::Class::Core";

__PACKAGE__->load_components(qw( Tree::Mobius +Elektrum::Schema::Phat ));

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
    "title",
    { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
    "body",
    { data_type => "mediumtext", default_value => "", is_nullable => 0 },
    "theme",
    { data_type => "varchar", is_nullable => 1, size => 255 },
    # SLUG SHOULD BE ANOTHER NODE
    "mime_type",
    {
        data_type => "text",
        default_value => "text/plain",
        is_nullable => 0,
        size => 40,
    },
    "commentflag",
    {
        data_type => "enum",
        default_value => "on",
        extra => { list => ["on", "off", "closed", "hide"] },
        is_nullable => 1,
    },
    "status",
    {
        data_type => "enum",
        default_value => "draft",
        extra => { list => ["publish", "draft", "deleted"] },
        is_nullable => 1,
    },
    "created",
    {
        data_type => "datetime",
        datetime_undef_if_invalid => 1,
        is_nullable => 1,
    },
    "updated",
    {
        data_type => "timestamp",
        datetime_undef_if_invalid => 1,
        default_value => \q{current_timestamp},
        is_nullable => 0,
    },
    );

__PACKAGE__->set_primary_key("id");

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

Stuff that needs to be considered for companion records/classes.

  "user",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "parent",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "note",
  { data_type => "text", is_nullable => 1 },
  "secret",
  { data_type => "mediumtext", is_nullable => 1 },
  "display_group",
  {
    data_type => "enum",
    default_value => "journal",
    extra => { list => ["journal", "aux", "standalone"] },
    is_nullable => 1,
  },
  "golive",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "takedown",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "2100-01-01 00:00:00",
    is_nullable => 1,
  },


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
