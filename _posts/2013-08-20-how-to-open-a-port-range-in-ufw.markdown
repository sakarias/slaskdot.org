---
layout: post
title: How to open a port range in ufw
date: "2013-08-20 12:46:52"
comments: true
tags: 
- linux
- ufw
- mosh
---

I'm a big user of [Mosh][1] when I'm out and about. Mosh uses UDP ports to connect back to the server, and this port range needs to be open on the server. By default Mosh uses the first available UDP port, starting at 60001 and stopping at 60999.

{% highlight console %}
ufw allow proto udp to any port 60001:60999
{% endhighlight %}

I use [ufw][2] on my servers, as an easy front end to [iptables][3].

[1]: http://mosh.mit.edu/
[2]: https://launchpad.net/ufw
[3]: http://en.wikipedia.org/wiki/Iptables
