package Elektrum::Controller::Meta;
use Moose;
use SQL::Translator;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
#    $c->stash( template => "node/index.tt" );
    $c->stash( ppid => getppid(),
                pid => $$,
        );
}

sub spec : Local Args(0) {
    my ( $self, $c ) = @_;

}

sub schema : Local Args(0) {
    my ( $self, $c ) = @_;
    my $schema = $c->model("DBIC")->schema;
    my $src = "/img/diagram-v" . $schema->VERSION . ".png";
    $c->stash( img_src => $src );
    my $file = $c->path_to("root/static", $src);
    return if !$c->request->query_params->{reset} and -f $file;
    my $trans = SQL::Translator->new(
        parser        => 'SQL::Translator::Parser::DBIx::Class',
        parser_args   => { package => blessed $schema },
        producer      => 'Diagram',
        producer_args => {
            out_file         => $file,
#            show_constraints => 1,
#            show_datatypes   => 1,
#            show_sizes       => 1,
#            show_fk_only     => 0,
        });

    $trans->translate;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

Look at https://github.com/pangyre/p5-ftl/blob/master/lib/FTL/Controller/Scritto.pm


