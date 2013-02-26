package SearchAd::Web::Model::DBIC::User;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

sub ACCEPT_CONTEXT {
    my ($self, $c) = @_;

    return $c->model('DBIC')->resultset('User');
}

__PACKAGE__->meta->make_immutable;

1;
