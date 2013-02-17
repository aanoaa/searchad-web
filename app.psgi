use strict;
use warnings;

use SearchAd::Web;
use Plack::Builder;

my $app = SearchAd::Web->apply_default_middlewares(SearchAd::Web->psgi_app);
builder {
    enable_if { $_[0]->{REMOTE_ADDR} eq '127.0.0.1' }
        "Plack::Middleware::ReverseProxy";
    enable "Plack::Middleware::Static",
        path => qr{^(?:/static/|/favicon\.ico)}, root => SearchAd::Web->path_to('root');
    $app;
};
