#! /bin/bash

function build {
  jekyll build
  if [ $? -ne 0 ];
    then
    echo "Build failed!"
    exit 1
  fi
}

function new {
  echo -n "Title : "
  read title
  title2=${title}
  title=$(echo ${title} | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
  cat <<EOF > _drafts/${title}.markdown
---
layout: post
title: ${title2}
date: unpublished
comments: true
tags: 
- 
---

![Alt text](/images/)
{% highlight console %}
{% endhighlight %}
EOF
  st _drafts/${title}.markdown
}

function publish {
  for file in _drafts/*
  do
    echo "Publish ${file} ?"
    read yn

    case "${yn}" in
      y)  fileTitle=$(grep title ${file} | cut -f 2 -d ":" | sed -e 's/^[ \t]*//' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
          mv ${file} _publish/${fileTitle}.markdown
          ;;

      *)  echo "Not publising ${file}"
          ;;
    esac
  done
  build
}

function change_url {
  awk 'NR==n{$2=a}1' n=1 a="${1}" _config.yml > tmp
  mv tmp _config.yml
}

function deploy {
  URL="http://slaskdot.org"
  change_url $URL
  build
  rsync -az -e ssh --delete _site/* charlie.rockstable.net:/home/sites/slaskdot.org/www/site/
  open $URL
}

function localtest {
  URL="http://slaskdot.home.rockstable.net"
  change_url $URL
  build
  rsync -az -e ssh --delete _site/* rs-web01.home.rockstable.net:/home/sites/slaskdot/www/
  open $URL
}

function local {
  URL="http://localhost:4000"
  change_url $URL
  jekyll serve --watch --future --drafts &
}

function usage {
  cat<<-EOF
  Usage of $(basename $0):

  build     Just build the site with Jekyll.
  new       Creates a new post.
  deploy    Builds and uploads the site to production environment
  test      Builds and uploads the site to testing environment.
  local     Starts jekyll in server mode.
  publish   Moves posts from _drafts to _publish, and builds them.

EOF
}

case "$1" in
  build)    build
            ;;

  new)      new
            ;;

  deploy)   deploy
            ;;

  test)     localtest
            ;;

  local)    local
            ;;

  publish)  publish
            ;;

  *)        usage
            ;;
esac
