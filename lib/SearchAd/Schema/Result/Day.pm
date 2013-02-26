use utf8;
package SearchAd::Schema::Result::Day;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SearchAd::Schema::Result::Day

=cut

use strict;
use warnings;

=head1 BASE CLASS: L<SearchAd::Schema::ResultBase>

=cut

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'SearchAd::Schema::ResultBase';

=head1 TABLE: C<day>

=cut

__PACKAGE__->table("day");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 day

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "day",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 bundle_days

Type: has_many

Related object: L<SearchAd::Schema::Result::BundleDay>

=cut

__PACKAGE__->has_many(
  "bundle_days",
  "SearchAd::Schema::Result::BundleDay",
  { "foreign.day_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 bundles

Type: many_to_many

Composing rels: L</bundle_days> -> bundle

=cut

__PACKAGE__->many_to_many("bundles", "bundle_days", "bundle");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-02-27 04:41:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8psKmFsXuUlt866XChPWdQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
