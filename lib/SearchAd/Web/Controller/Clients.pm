package SearchAd::Web::Controller::Clients;
use Moose;
use namespace::autoclean;

use WWW::Naver::SearchAd;

BEGIN { extends 'Catalyst::Controller'; }

=head1 METHODS

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->detach('index_POST') if $c->req->method eq 'POST';
    $c->stash->{clients} = [$c->model('DBIC')->resultset('Client')->search];
}

sub _object :Chained :PathPart('clients') :CaptureArgs(1) {
    my ($self, $c, $username) = @_;

    $c->stash->{client} = $c->model('DBIC')->resultset('Client')->find({ username => $username });
}

sub object :Chained('_object') PathPart('') :Args(0) {
    my ($self, $c) = @_;

    $c->detach('object_DELETE') if $c->req->method eq 'DELETE';
}

sub object_DELETE :Action {
    my ($self, $c) = @_;

    my $client = $c->stash->{client};
    for my $bundle ($client->bundles) {
        $bundle->delete;
    }

    $client->delete;

    $c->res->body('deleted');
}

sub add :Local {
    my ($self, $c) = @_;
}

sub index_POST :Action {
    my ($self, $c) = @_;

    # validation?

    my $username = $c->req->param('username');
    my $password = $c->req->param('password');

    my $client_rs = $c->model('DBIC')->resultset('Client');
    my $added = $client_rs->update_or_create({
        username => $username,
        password => $password,
        user_id  => $c->user->id,
    });

    unless ($added) {
        # TODO: error handling
    }

    $c->res->redirect($c->uri_for($added->username));
}

sub sync :Chained('_object') :PathPart('sync') :Args(0) {
    my ($self, $c) = @_;

    my $client = $c->stash->{client};
    my $bundle_rs = $c->model('DBIC')->resultset('Bundle');

    my $agent = WWW::Naver::SearchAd->new;
    if ($agent->signin($client->username, $client->password)) {
        if (my $bundles = $agent->get_bundles) {
            for my $bundle (@$bundles) {
                $bundle_rs->update_or_create({
                    id        => $bundle->{bundleId},
                    client_id => $client->id,
                    name      => $bundle->{bundleName},
                });

                $c->res->redirect($c->uri_for($client->username));
            }
        } else {
            $c->stash->{error} = $agent->{error};
            $c->detach('/error/502');
        }
    } else {
        $c->stash->{error} = $agent->{error};
        $c->detach('/error/502');
    }
}

__PACKAGE__->meta->make_immutable;

1;
