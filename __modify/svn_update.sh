#!/bin/sh

cd .. || exit 1
svn update 2>&1 | tee /tmp/svn.txt
