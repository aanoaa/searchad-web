use utf8;
package SearchAd::Schema::Result::BundleDay;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SearchAd::Schema::Result::BundleDay

=cut

use strict;
use warnings;

=head1 BASE CLASS: L<SearchAd::Schema::ResultBase>

=cut

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'SearchAd::Schema::ResultBase';

=head1 TABLE: C<bundle_day>

=cut

__PACKAGE__->table("bundle_day");

=head1 ACCESSORS

=head2 bundle_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 day_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "bundle_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "day_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</bundle_id>

=item * L</day_id>

=back

=cut

__PACKAGE__->set_primary_key("bundle_id", "day_id");

=head1 RELATIONS

=head2 bundle

Type: belongs_to

Related object: L<SearchAd::Schema::Result::Bundle>

=cut

__PACKAGE__->belongs_to(
  "bundle",
  "SearchAd::Schema::Result::Bundle",
  { id => "bundle_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 day

Type: belongs_to

Related object: L<SearchAd::Schema::Result::Day>

=cut

__PACKAGE__->belongs_to(
  "day",
  "SearchAd::Schema::Result::Day",
  { id => "day_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-02-27 04:41:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Q9KEjbICtiG5lwpG4eLBtg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
