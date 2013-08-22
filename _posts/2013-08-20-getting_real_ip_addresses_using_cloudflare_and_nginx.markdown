---
layout: post
title: Getting real IP addresses using CloudFlare and Nginx
date: "2013-08-20 01:21:26"
comments: true
tags: 
- linux
- nginx
- cloudflare
---

## Before you start

Before you start, you have to check if your [nginx][1] have been compiled with ``--with-http_realip_module``, you do that by running the command ``nginx -V`` and look for the module.

{% highlight bash %}
# nginx -V
nginx version: nginx/1.2.1
TLS SNI support enabled
configure arguments: --prefix=/etc/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --lock-path=/var/lock/nginx.lock --pid-path=/var/run/nginx.pid --with-pcre-jit --with-debug --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_sub_module --with-http_xslt_module --with-ipv6 --with-sha1=/usr/include/openssl --with-md5=/usr/include/openssl --with-mail --with-mail_ssl_module --add-module=/tmp/buildd/nginx-1.2.1/debian/modules/nginx-auth-pam --add-module=/tmp/buildd/nginx-1.2.1/debian/modules/nginx-echo --add-module=/tmp/buildd/nginx-1.2.1/debian/modules/nginx-upstream-fair --add-module=/tmp/buildd/nginx-1.2.1/debian/modules/nginx-dav-ext-module
{% endhighlight %}

This is my output from an standard [Debian][2] installed nginx package.

## Nginx configuration

The documentation for HttpRealipModule module states that the configuration should be in either http, server or location context. You probably want to add these server wide, in ``/etc/nginx/nginx.conf``. But this file is likely to be overwritten by an update, so I recommend to make a ``cloudflare.conf``file in ``/etc/nginx/conf.d``.

### Content of /etc/nginx/conf.d/cloudflare.conf

{% highlight console %}

set_real_ip_from   204.93.240.0/24;
set_real_ip_from   204.93.177.0/24;
set_real_ip_from   199.27.128.0/21;
set_real_ip_from   173.245.48.0/20;
set_real_ip_from   103.21.244.0/22;
set_real_ip_from   103.22.200.0/22;
set_real_ip_from   103.31.4.0/22;
set_real_ip_from   141.101.64.0/18;
set_real_ip_from   108.162.192.0/18;
set_real_ip_from   190.93.240.0/20;
set_real_ip_from   188.114.96.0/20;
set_real_ip_from   197.234.240.0/22;
set_real_ip_from   198.41.128.0/17;
set_real_ip_from   162.158.0.0/15;
set_real_ip_from   2400:cb00::/32;
set_real_ip_from   2606:4700::/32;
set_real_ip_from   2803:f800::/32;
set_real_ip_from   2405:b500::/32;
set_real_ip_from   2405:8100::/32;
real_ip_header     CF-Connecting-IP;

{% endhighlight %}

CloudFlare do change their [IPs][3] from time to time (they keep an updated list online), and since we have the list of IPs in an separate file, its easy to automate an update of these.

An update script would look something like this:

{% highlight bash %}

#! /bin/bash
#
# Update cloudflare.conf with new IPs
#

cloudFlareConf="/etc/nginx/conf.d/cloudflare.conf"
IPV4=$(curl -s "https://www.cloudflare.com/ips-v4")
IPV6=$(curl -s "https://www.cloudflare.com/ips-v6")
DATE="$(date)"

echo "# Last updated ${DATE}" > ${cloudFlareConf}

for IPV4ip in ${IPV4}
do 
  echo "set_real_ip_from ${IPV4ip};" >> ${cloudFlareConf}
done

for IPV6ip in ${IPV6}
do
  echo "set_real_ip_from ${IPV6ip};" >> ${cloudFlareConf}
done

echo "real_ip_header CF-Connecting-IP;" >> ${cloudFlareConf}

{% endhighlight %}

[1]: http://nginx.org
[2]: http://www.debian.org
[3]: https://www.cloudflare.com/ips
[4]: http://wiki.nginx.org/HttpRealipModule
