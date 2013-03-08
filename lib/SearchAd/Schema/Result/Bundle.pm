use utf8;
package SearchAd::Schema::Result::Bundle;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SearchAd::Schema::Result::Bundle

=cut

use strict;
use warnings;

=head1 BASE CLASS: L<SearchAd::Schema::ResultBase>

=cut

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'SearchAd::Schema::ResultBase';

=head1 TABLE: C<bundle>

=cut

__PACKAGE__->table("bundle");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 client_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 rank

  data_type: 'integer'
  default_value: 15
  is_nullable: 1

=head2 limit

  data_type: 'integer'
  default_value: null
  is_nullable: 1

=head2 interval

  data_type: 'integer'
  default_value: 60
  is_nullable: 1

=head2 active

  data_type: 'integer'
  default_value: 1
  is_nullable: 1

=head2 refresh_at

  data_type: 'integer'
  inflate_datetime: 'epoch'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "client_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "rank",
  { data_type => "integer", default_value => 15, is_nullable => 1 },
  "limit",
  { data_type => "integer", default_value => \"null", is_nullable => 1 },
  "interval",
  { data_type => "integer", default_value => 60, is_nullable => 1 },
  "active",
  { data_type => "integer", default_value => 1, is_nullable => 1 },
  "refresh_at",
  { data_type => "integer", inflate_datetime => "epoch", is_nullable => 1 },
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
  { "foreign.bundle_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 client

Type: belongs_to

Related object: L<SearchAd::Schema::Result::Client>

=cut

__PACKAGE__->belongs_to(
  "client",
  "SearchAd::Schema::Result::Client",
  { id => "client_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 histories

Type: has_many

Related object: L<SearchAd::Schema::Result::History>

=cut

__PACKAGE__->has_many(
  "histories",
  "SearchAd::Schema::Result::History",
  { "foreign.bundle_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 days

Type: many_to_many

Composing rels: L</bundle_days> -> day

=cut

__PACKAGE__->many_to_many("days", "bundle_days", "day");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-03-08 18:17:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ogkVMeOX4dFTM1T4WaEqfw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
