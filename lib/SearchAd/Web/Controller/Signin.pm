package SearchAd::Web::Controller::Signin;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 METHODS

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->forward('index_POST') if $c->req->method eq 'POST';
}

sub index_POST :Action {
    my ($self, $c) = @_;

    $c->detach unless $c->forward('/validate/signin');

    my $username = $c->req->param('username');
    my $password = $c->req->param('password');

    if ($c->authenticate({ username => $username, password => $password })) {
        if (my $uri = delete $c->session->{uri}) {
            $c->res->redirect($uri);
        } else {
            $c->res->redirect('/');
        }
    } else {
        $c->stash->{error} = 'incorrect username or password';
    }
}

sub intro :Path('/intro') :Args(0) {
    my ($self, $c) = @_;
}

sub signon :Path('/signon') :Args(0) {
    my ($self, $c) = @_;

    $c->forward('index_POST') if $c->req->method eq 'POST';
}

sub signon_POST :Action { }

__PACKAGE__->meta->make_immutable;

1;
