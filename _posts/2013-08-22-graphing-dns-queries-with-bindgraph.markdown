---
layout: post
title: Graphing DNS queries with bindgraph
date: "2013-08-22 11:56:52"
comments: true
tags: 
- bindgraph
- bind
- linux
- monitoring
- dns
---

[Bindgraph][1] is a tool that allow us to make graphs over queries resolved by our DNS servers. 

To be able to use bindgraph, we need to configure [bind][2] to store its queries in a log file that bindgraph can read.


## Installing bindgraph

{% highlight console %}
# apt-get install bindgraph
{% endhighlight %}

## Enabling logging in bind9

Add the following line in ``/etc/bind/named.conf``, right after the other includes.

{% highlight bash %}
include "/etc/bind/named.conf.log";
{% endhighlight %}

In ``/etc/bind/named.conf.log`` add the following configuration:

{% highlight bash %}

logging {
  category security { security_channel; default; };
  category lame-servers { null; };
  category default { default; };
  category queries { querylog; };

  channel security_channel {
    file            "/var/log/named/security.log";
    severity        debug;
    print-time      yes;
    print-category  yes;
    print-severity  yes;
  };

  channel default {
    file            "/var/log/named/bind.log" versions 3 size 5m;
    severity        warning;
    print-time      yes;
    print-category  yes;
    print-severity  yes;
  };

  channel "querylog" {
    file            "/var/log/named/bind-queries.log";
    print-time      yes;
    print-category  yes;
  };
};

{% endhighlight %}

Now we have enabled logging in bind9, but we also need to create the folder its going to write its log files to and set the right permissions.

{% highlight console %}
# mkdir /var/log/named
# chown bind:bind /var/log/named/
{% endhighlight %}

## Configuring bindgraph

In ``/etc/default/bindgraph`` edit the line starting with ``DNS_LOG`` so that it points to the correct log file.

{% highlight bash %}
DNS_LOG=/var/log/named/bind-queries.log
{% endhighlight %}

Last thing we need to do, is to restart bind9 and bindgraph services.

{% highlight console %}
# service bind9 restart
# service bindgraph restart
{% endhighlight %}

## Viewing the graphs

To be able to see the graphs, bindgraph has a CGI front end, so we need an web server that can show us the graphs, I'm using Apache for this.

Just install Apache with ``apt-get install apache2`` and point your web browser to <FQDN-of-dns-server/cgi-bin/bindgraph.cgi>.

![Bindgraph Hourly](/images/bindgraph_graph.png)

[1]: http://www.linux.it/~md/software/
[2]: http://www.bind9.net/
