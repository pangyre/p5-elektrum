use strict;
use warnings;
use Test::More;
use ElekTest;
# use Elektrum::Controller::User;
#use Catalyst::Test "Elektrum";

my @plain_get = qw(
                   /user
                   /user/login
                   /user/logout
                 );

for my $get ( @plain_get )
{
    ok( my $response = request($get), "GET $get" );

    if ( $response->code == 200 )
    {
        pass("Success");
    }
    elsif ( $response->code == 302 )
    {
        pass("Redirect");
    }
    else
    {
        fail("Bad response " . $response->status_message);
    }

}

# Login incorrectly.
{
    my $response = request POST "/user/login",
        [ bar => 'baz', something => 'else' ];
    ok( $response->is_success, "Bad POST to /user/login" )
        or note( $response->status_line );

}

# Register correctly.
{
    "";
}

done_testing();


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
