package Elektrum::Role::RS;
use Moose::Role;
use namespace::autoclean;
requires "base";

has "rs" =>
    is => "ro",
    isa => "Object",
    writer => "set_rs",
    init_arg => undef, # No?
    ;

has "model" =>
    is => "ro",
    isa => "Str|Object",
    predicate => "has_model",
    writer => "set_model",
    ;

after "base" => sub {
    my ( $self, $c ) = @_;
    my $class = blessed($self);
    unless ( $self->has_model )
    {
        ( my $model = $class ) =~ s/\A.+::/DBIC::/; # E.g., Elektrum::Controller::Node
        $self->set_model( $c->model($model) );
    }
    $self->set_rs( $self->model->search_rs );
};

sub txn_scope_guard {
    my ( $self, $c ) = @_;
    $self->model->result_source->schema->txn_scope_guard;
}

1;

__END__


