---
layout: post
title: HP Array Configuration Utility CLI for Linux
date: 2013-08-19 00:48:48
comments: true
tags: 
- linux
- hp
- hewlett packard
- hpacucli
---

[HP][1] [Array Configuration Utility CLI][3] for Linux (hpacucli) is a program for controlling [HP Smart Array controllers][2].

To invoke the interactive shell, run the command ``hpacucli``. for help run ``hpacucli help``.

## Controller Commands

### Display detail of Controller

{% highlight bash %}
hpacucli> ctrl all show config
hpacucli> ctrl all show config detail
{% endhighlight %}

### Display status of Controller

{% highlight bash %}
hpacucli> ctrl all show status
{% endhighlight %}

### Enable or Disable the cache

{% highlight bash %}
hpacucli> ctrl slot=0 modify dwc=disable
hpacucli> ctrl slot=0 modify dwc=enable
{% endhighlight %}

### Detects newly added devices since the last rescan

{% highlight bash %}
hpacucli> rescan
{% endhighlight %}

## Physical Drive Commands

### Display detail information of physicalDrive

{% highlight bash %}
hpacucli> ctrl slot=0 pd all show
hpacucli> ctrl slot=0 pd 2:3 show detail
{% endhighlight %}

### Display Status of physicalDrive

{% highlight bash %}
hpacucli> ctrl slot=0 pd all show status
hpacucli> ctrl slot=0 pd 2:3 show status
{% endhighlight %}

### To Erase the physicalDrive

{% highlight bash %}
hpacucli> ctrl slot=0 pd 2:3 modify erase
{% endhighlight %}

### To enable or Disable the LED

{% highlight bash %}
hpacucli> ctrl slot=0 pd 2:3 modify led=on
hpacucli> ctrl slot=0 pd 2:3 modify led=off
{% endhighlight %}

## Logical Drive Commands

### Display detail information of LogicalDrive

{% highlight bash %}
hpacucli> ctrl slot=0 ld all show
hpacucli> ctrl slot=0 ld 4 show 
{% endhighlight %}

### Display Status of LogicalDrive

{% highlight bash %}
hpacucli> ctrl slot=0 ld all show status
hpacucli> ctrl slot=0 ld 4 show status
{% endhighlight %}

### To re-enabling failed drive

{% highlight bash %}
hpacucli> ctrl slot=0 ld 4 modify reenable forced
{% endhighlight %}

### Create LogicalDrive with RAID 0 using one drive:
{% highlight bash %}
hpacucli> ctrl slot=0 create type=ld drives=1:12 raid=0        
{% endhighlight %}

### Create LogicalDrive with RAID 1 using two drives:
{% highlight bash %}
hpacucli> ctrl slot=0 create type=ld drives=1:13,1:14 size=300 raid=1
{% endhighlight %}

### Create LogicalDrive with RAID 5 using five drives:
{% highlight bash %}
hpacucli> ctrl slot=0 create type=ld drives=1:13,1:14,1:15,1:16,1:17 raid=5
{% endhighlight %}

### To Delete LogicalDrives

{% highlight bash %}
hpacucli> ctrl slot=0 ld 4 delete
{% endhighlight %}

### Expanding logicaldrive by adding one more drive

{% highlight bash %}
hpacucli> ctrl slot=0 ld 4 add drives=2:3
{% endhighlight %}

### Extending the LogicalDrives

{% highlight bash %}
hpacucli> ctrl slot=0 ld 4 modify size=500 forced
{% endhighlight %}

### Add two Spare disks

{% highlight bash %}
hpacucli> ctrl slot=0 array all add spares=1:5,1:7 
{% endhighlight %}


[1]: http://en.wikipedia.org/wiki/Hewlett-Packard
[2]: http://h18004.www1.hp.com/products/servers/proliantstorage/arraycontrollers/
[3]: http://h20000.www2.hp.com/bizsupport/TechSupport/SoftwareDescription.jsp?swItem=MTX-66b08e49c28f4bd49f4641ed80
