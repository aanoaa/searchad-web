#!/usr/bin/env perl
use strict;
use warnings;
use DateTime;

use AnyEvent;
use AnyEvent::IRC::Client;

use lib 'lib';
use SearchAd::DBIC;

my $channel  = $ENV{SBM_ROOM}   or die "SBM_ROOM needed\n";
my $server   = $ENV{SBM_SERVER} or die "SBM_SERVER needed\n";
my $port     = $ENV{SBM_PORT}   or die "SBM_PORT needed\n";
my $password = $ENV{SBM_PASSWORD} || '';

my $schema = SearchAd::DBIC->new({
    connect_info => {
        dsn        => "dbi:SQLite:db/searchad.db",
        quote_char => q{`},
    }
});

my $condvar = AnyEvent->condvar;
my $irc     = AnyEvent::IRC::Client->new;;

$irc->reg_cb(
    connect => sub {
        my ($con, $err) = @_;
        if (defined $err) {
            warn "connect error: $err\n";
            return;
        }

        $irc->send_srv(JOIN => $channel);
    },
    join => sub {
        my ( $cl, $nick, $channel, $is_myself ) = @_;
        print "joined $channel\n";
        while (1) {
            select_bundle();
            sleep 60;
        }
    },
);

my $options = {
    nick     => 'commando',
    password => $password,
    timeout  => 10, # wait 10 seconds
};

$irc->connect(
    $server,
    $port,
    $options,
);

$condvar->recv;

sub select_bundle {
    my $epoch = DateTime->now->epoch;
    my $rs = $schema->resultset('Bundle')->search_literal(
        'me.refresh_at <= (? - (me.interval * 60)) OR me.refresh_at is NULL',
        $epoch
    );

    my %client;
    while (my $row = $rs->next) {
        my $username = $row->client->username;
        $client{$username} ||= [];
        push @{ $client{$username} }, $row->id . ':' . $row->rank;
        $row->refresh_at($epoch);
        $row->update; # DBIC not suppoted `txn_do` for SQLite
    }

    for my $username (keys %client) {
        $irc->send_srv(
            'PRIVMSG',
            $channel,
            "$username: searchad " . join ' ', @{ $client{$username} }
        );
    }
}
