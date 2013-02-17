package SearchAd::DBIC;
use Moose;
use namespace::autoclean;

use SearchAd::Schema;

has schema => (
    is => 'ro',
    lazy_build => 1,
    handles => {
        txn_guard => 'txn_scope_guard',
    }
);

has connect_info => (
    is => 'ro',
    isa => 'HashRef',
);

has default_moniker => (
    is => 'ro',
    isa => 'Maybe[Str]',
    lazy_build => 1,
);

has resultset_constraints => (
    is => 'ro',
    isa => 'HashRef',
    predicate => 'has_resultset_constraints',
);

sub _build_resultset_constraints { return +{} }
sub _build_default_moniker { '' } # no default moniker
sub _build_schema { SearchAd::Schema->connect(shift->connect_info) }

sub resultset {
    my ($self, $moniker) = @_;

    my $schema = $self->schema();
    $moniker ||= $self->default_moniker;
    if (! $moniker) {
        confess blessed($self) . "->resultset() did not receive a moniker, nor does it have a default moniker";
    }

    my $rs = $schema->resultset($moniker);
    if ( $moniker eq $self->default_moniker && $self->has_resultset_constraints ) {
        return $rs->search( $self->resultset_constraints );
    } else {
        return $rs;
    }
}

__PACKAGE__->meta->make_immutable;

1;
