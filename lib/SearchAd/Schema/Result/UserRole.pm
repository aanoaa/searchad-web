use utf8;
package SearchAd::Schema::Result::UserRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SearchAd::Schema::Result::UserRole

=cut

use strict;
use warnings;

=head1 BASE CLASS: L<SearchAd::Schema::ResultBase>

=cut

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'SearchAd::Schema::ResultBase';

=head1 TABLE: C<user_role>

=cut

__PACKAGE__->table("user_role");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 role_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "role_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=item * L</role_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id", "role_id");

=head1 RELATIONS

=head2 role

Type: belongs_to

Related object: L<SearchAd::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "role",
  "SearchAd::Schema::Result::Role",
  { id => "role_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 user

Type: belongs_to

Related object: L<SearchAd::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "SearchAd::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-02-26 23:37:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:arWQMzOfKJ4H01x6hey+Tw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
