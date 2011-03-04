use strict;
use warnings;
use Test::More;
# use Catalyst::Test "Elektrum";
use ElekTest;
use Elektrum::Controller::User;

my @plain_get = qw(
                   /user
                   /user/register
                   /user/login
                   /user/logout
                 );

for my $get ( @plain_get )
{
    ok( request($get)->is_success, "GET $get" );
    last if $get eq "register";
}

done_testing();

# Register incorrectly.
{
    my $response = request POST "/user/register",
        [ bar => 'baz', something => 'else' ];
    ok( $response->is_success, "Bad POST to /user/register" );

}

# Register correctly.
{
    "";
}

__END__

# Sign-in with openID.
{

}


# Sign-in.
{

}

# Edit prefs.
{

}


# Sign-out.
{

}

# Check stuff.
{

}


# Sign-in again.
{

}
