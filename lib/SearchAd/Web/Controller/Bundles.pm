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

sub _bundle :Chained('/clients/_object') PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    $c->stash->{bundle} = $c->model('DBIC')->resultset('Bundle')->find({ id => $id });
}

sub bundle :Chained('_bundle') PathPart('') :Args(0) {
    my ($self, $c, $id) = @_;

    $c->detach('bundle_POST') if $c->req->method eq 'POST';
    $c->detach('bundle_DELETE') if $c->req->method eq 'DELETE';
    $c->detach('bundle_PUT') if $c->req->method eq 'PUT';

    my $bundle = $c->stash->{bundle};
    $c->stash->{history} = {
        success => [$bundle->search_related('histories', { status => 1 })],
        fail    => [$bundle->search_related('histories', { status => 0 })],
    };
}

sub bundle_POST :Action {
    my ($self, $c) = @_;

    my $bundle = $c->stash->{bundle};
    $bundle->name($c->req->param('name'));
    $bundle->rank($c->req->param('rank'));
    $bundle->interval($c->req->param('interval'));
    $bundle->limit($c->req->param('limit'));
    $bundle->update;

    $c->res->redirect(
        $c->uri_for(
            '/clients',
            $c->stash->{client}->username,
            $bundle->id
        )
    );
}

sub bundle_DELETE :Action {
    my ($self, $c) = @_;

    my $bundle = $c->stash->{bundle};
    $bundle->delete_related('histories');
    $bundle->delete_related('bundle_days');
    $bundle->delete;
    $c->res->body('deleted');
}

sub bundle_PUT :Action {
    my ($self, $c) = @_;

    my $bundle = $c->stash->{bundle};
    $bundle->update($c->req->params);
    $c->res->body('updated');
}

sub _days :Chained('_bundle') :PathPart('days') :CaptureArgs(0) { }
sub days  :Chained('_days') :PathPart('') :Args(0) { }
sub _day  :Chained('_days') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $day) = @_;

    $c->stash->{day} = $c->model('DBIC')->resultset('Day')->find({ day => $day });
}

sub day :Chained('_day') :PathPart('') :Args(0) {
    my ($self, $c) = @_;

    $c->detach('day_POST') if $c->req->method eq 'POST';
    $c->detach('day_DELETE') if $c->req->method eq 'DELETE';
}

# bundle.days('day' => day)
sub day_POST :Action {
    my ($self, $c) = @_;

    my $day    = $c->stash->{day};
    my $bundle = $c->stash->{bundle};
    $bundle->create_related('bundle_days', { day_id => $day->id });
    $c->res->body('created');
}

sub day_DELETE :Action {
    my ($self, $c) = @_;

    my $day    = $c->stash->{day};
    my $bundle = $c->stash->{bundle};
    $bundle->delete_related('bundle_days', { day_id => $day->id });
    $c->res->body('deleted');
}

__PACKAGE__->meta->make_immutable;

1;
