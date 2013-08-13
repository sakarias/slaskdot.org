---
layout: post
title: Homebrew Cask 
date: 2013-07-07 04:24:24
comments: true
tags: 
- Mac OS X
- Homebrew
- Cask
---

[Homebrew][1] is an package manager for OSX, that lets you easily install software that Apple did not ship with OSX. [Homebrew Cask][2] is an extension to Homebrew, to install and keep control over Mac applications distributed as binaries.

## Installation

Open an terminal (Terminal.app or iTerm2.app) and type in the following commands.

{% highlight bash %}
    $ brew tap phinze/homebrew-cask
    $ brew install brew-cask
{% endhighlight %}

When they have run, you should have Homebrew Cask installed on your system.

## Usage

### List installable packages

{% highlight bash %}
    $ brew cask search
{% endhighlight %}

### Install package
{% highlight bash %}
    $ brew cask install google-chrome
{% endhighlight %}

### List installed packages

{% highlight bash %}
    $ brew cask list
{% endhighlight %}

### Remove installed packages

{% highlight bash %}
    $ brew cask uninstall
{% endhighlight %}

## The applications that I use.

{% highlight bash %}
    brew cask install alfred
    brew cask install cord
    brew cask install dropbox
    brew cask install evernote
    brew cask install f-lux
    brew cask install firefox
    brew cask install google-chrome
    brew cask install istat-menus
    brew cask install iterm2
    brew cask install the-unarchiver
    brew cask install totalspaces
    brew cask install tower
    brew cask install transmit
    brew cask install one-password
    brew cask install spotify
    brew cask install vlc
    brew cask install sublime-text
{% endhighlight %}

[1]: http://brew.sh/
[2]: https://github.com/phinze/homebrew-cask
