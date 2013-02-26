package SearchAd::Web::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my @clients_id;
    map { push @clients_id, $_->id } $c->user->clients;
    my @bundles = $c->model('DBIC')->resultset('Bundle')->search({
        client_id => { -in => \@clients_id }
    });

    my %items;
    map { push $items{$_->rank} ||= [], $_ } @bundles;
    $c->stash->{items} = \%items;
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub error: Action :Args(1) {
    my ($self, $c, $code) = @_;

    $c->res->code($code);
    $c->stash->{template} = "errors/$code.tt";
}

sub auto :Private {
    my ($self, $c) = @_;

    return 1 if $c->controller eq $c->controller('Signin');

    if (!$c->user_exists) {
        $c->session->{uri} = $c->req->uri;
        $c->res->redirect('/intro');
        return 0;
    }

    return 1;
}

sub validate :Action :Args(1) {
    my ($self, $c, $method) = @_;

    $c->model("Validator")->$method;
    if ($c->form->has_error) {
        $c->stash->{error} = $c->form->messages($method);
        return 0;
    }

    return 1;
}

sub end : ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;

1;
