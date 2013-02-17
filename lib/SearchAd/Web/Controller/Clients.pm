package SearchAd::Web::Controller::Clients;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 METHODS

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{clients} = [$c->model('DBIC')->resultset('Client')->search];
}

sub _object :Chained :PathPart('clients') :CaptureArgs(1) {
    my ($self, $c, $username) = @_;

    $c->stash->{client} = $c->model('DBIC')->resultset('Client')->find({ username => $username });
}

sub object :Chained('_object') PathPart('') :Args(0) {
    my ($self, $c) = @_;
}

__PACKAGE__->meta->make_immutable;

1;
