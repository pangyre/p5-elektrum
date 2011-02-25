use ElekTest;
use strict;
use utf8;

while ( my $route = <DATA>)
{
    chomp $route;
    my $response = request($route);

    if ( $response->decoded_content =~ /file error .+?\.tt: not found/ )
    {
      TODO: {
          local $TODO = "Template not implemented";
          ok($response->is_success, "GET $route");
        };
    }
    elsif ( $response->decoded_content =~ /file error .+?\.tt: not found/ )
    {   
      TODO: {
          local $TODO ="Template not implemented";
          ok($response->is_success, "GET $route");

        };
    }
    elsif ( $response->code == 404 )
    {
        fail("$route not found");
    }
    elsif ( $response->is_success )
    {
        pass("GET $route");
    }
    else
    {
        fail("GET $route");
        BAIL_OUT("No point in testing futher");
    }
}

done_testing();

__END__
/
/n
/n/{id}
/n/{id}/preview
/n/{id}/edit
/n/{id}/rev
/n/{id}/rev/{¿guid?}
/n/{id}/preview/{token}
/n/random
/n/tag/{tag};{tag};{tag}
/n/tag/{tag};{tag}/random
/n/new
/n/search/{terms}
/user
/user/{id}
/user/{id}/edit
/user/register
/user/confirm/{token}
/user/login
/user/logout
/user/{id}/edit
/sitemap
/sitemap.xml
/referer
/dav
/chat
/admin/config/dump
/admin/crontab
/admin/dump
/admin/inc
/admin/{¿ping?}
/admin/niceuri
/admin/niceuri/{string}
