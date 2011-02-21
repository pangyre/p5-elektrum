use strict;
use warnings;
use Test::More;

use Catalyst::Test 'Elektrum';
use Elektrum::Controller::Node;

ok( request('/n')->is_success, 'Request should succeed' );
done_testing();
