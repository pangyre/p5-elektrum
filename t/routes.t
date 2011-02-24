use ElekTest;

while (<DATA>)
{
    diag($_);
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
./atom
/admin/niceuri
/admin/niceuri/{string}
