package SearchAd::Web::Model::Validator;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Component::ACCEPT_CONTEXT', 'Catalyst::Model';

sub signin {
    my $self = shift;

    my $c = $self->context;
    $c->form(
        username => ['NOT_BLANK'],
        password => ['NOT_BLANK'],
    );
}

sub signon {
    my $self = shift;

    my $c = $self->context;
    $c->form(
        username => ['NOT_BLANK'],
        password => ['NOT_BLANK'],
    );

    return if $c->form->has_error;

    my $user = $c->model('DBIC')->resultset('User')->find({ username => $c->req->param('username') });
    if ($user) {
        $c->set_invalid_form( username => 'EXIST' );
    }
}

__PACKAGE__->meta->make_immutable;

1;
