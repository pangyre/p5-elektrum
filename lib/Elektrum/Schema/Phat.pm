package Elektrum::Schema::Phat;
use warnings;
use strict;
use parent "DBIx::Class::Core";

sub TO_JSON { return { +shift->get_columns } }

sub new {
    my $self = +shift->next::method(@_);
    $self->created(\q{datetime('now')}) unless $self->created;
    $self->updated(\q{datetime('now')}) unless $self->updated;
    $self;
}

sub update {
    my ( $self, @args ) = @_;
    $self->updated(\q{datetime('now')});
    $self->next::method(@args);
}

1;

__END__

sub insert {
    my ( $self, @args ) = @_;

    $self->updated(\q{datetime('now')}) unless $self->updated;

    if ( $self->result_source->has_column("parent") and $self->get_column("parent") )
    {
        my $id = $self->get_column("parent");
        $self->result_source->resultset->find($id)
            or croak "Parent ", $id, " was not found";
        my $guard = $self->result_source->schema->txn_scope_guard;
        $self->next::method(@args);
        $self->parents; # Fatal if circular. Not efficient...
        $guard->commit;
        return $self;
    }
    else
    {
        my $guard = $self->result_source->schema->txn_scope_guard;
        $self->next::method(@args);
        $guard->commit;
        return $self;
    }
}
