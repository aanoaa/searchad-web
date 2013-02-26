package SearchAd::Web::Controller::Signout;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 METHODS

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->logout;
    $c->res->redirect($c->uri_for('/'));
}

__PACKAGE__->meta->make_immutable;

1;
