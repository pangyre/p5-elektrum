use strict;
use warnings;
use Test::More;
use Catalyst::Test "Elektrum";
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

__END__

# Sign-in with openID.
{

}

# Register incorrectly.
{

}

# Register correctly.
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
