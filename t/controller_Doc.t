use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Elektrum';
use Elektrum::Controller::Doc;

ok( request('/doc')->is_success, 'Request should succeed' );
done_testing();
