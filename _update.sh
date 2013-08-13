#! /bin/bash

case "$1" in
  build)  jekyll build
          ;;

  deploy) rsync -az -e ssh --delete _site/* charlie.rockstable.net:/home/sites/slaskdot.org/www/site/
          open http://slaskdot.org/
          ;;

  test)   rsync -az -e ssh --delete _site/* rs-web01.home.rockstable.net:/home/sites/slaskdot/www/
          open http://slaskdot.home.rockstable.net/
          ;;

  *)      echo "Usage, $0 [build|deploy|test]"
          ;;
esac
