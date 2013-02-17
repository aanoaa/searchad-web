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
  is_nullable: 1

=head2 interval

  data_type: 'integer'
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
  { data_type => "integer", is_nullable => 1 },
  "interval",
  { data_type => "integer", is_nullable => 1 },
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


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-02-17 18:28:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cyPqgcnAFu18grfQ6PZAXw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
