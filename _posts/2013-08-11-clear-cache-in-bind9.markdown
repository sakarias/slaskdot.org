---
layout: post
title: Clear cache on Bind9
date: 2013-08-11 19:34:34
description: Clear cache in Bind9
comments: true
tags: 
- linux
- dns
- bind
---

Its simple as:
{% highlight console %}
rndc flush
{% endhighlight %}
