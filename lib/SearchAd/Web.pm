package SearchAd::Web;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw[
    -Debug
    ConfigLoader
    Unicode::Encoding
    Authentication
    FillInForm
    Session
    Session::Store::FastMmap
    Session::State::Cookie
    FormValidator::Simple
];

extends 'Catalyst';

our $VERSION = '0.01';

# Start the application
__PACKAGE__->setup();

1;
