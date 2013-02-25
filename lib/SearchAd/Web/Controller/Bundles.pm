package SearchAd::Web::Controller::Bundles;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 METHODS

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{bundles} = [$c->model('DBIC')->resultset('Bundle')->search];
}

sub bundle :Chained('/clients/_object') PathPart('') :Args(1) {
    my ($self, $c, $id) = @_;

    $c->stash->{bundle} = $c->model('DBIC')->resultset('Bundle')->find({ id => $id });

    $c->detach('bundle_POST') if $c->req->method eq 'POST';
    $c->detach('bundle_DELETE') if $c->req->method eq 'DELETE';
}

sub bundle_POST :Action {
    my ($self, $c) = @_;

    my $bundle = $c->stash->{bundle};
    $bundle->name($c->req->param('name'));
    $bundle->rank($c->req->param('rank'));
    $bundle->interval($c->req->param('interval'));
    $bundle->update;

    $c->res->redirect(
        $c->uri_for(
            '/clients',
            $c->stash->{client}->username
        )
    );
}

sub bundle_DELETE :Action {
    my ($self, $c) = @_;

    my $bundle = $c->stash->{bundle};
    $bundle->delete;
    $c->res->body('deleted');
}

__PACKAGE__->meta->make_immutable;

1;
