#!/bin/sh


# -- check running in src dir --
if [ ! -O Makefile ]; then
  echo "not in source dir or not source files' owner" 1>&2
  exit 1
fi

# -- update --
svn update 2>&1 | tee /tmp/svn.txt
