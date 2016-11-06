#!/bin/sh

if [ "`id -u`" != "0" ]; then
  echo "sorry, this must be done as root." 1>&2
  exit 1
fi

usage()
{
  cat 1>&2 <<EOF
usage: build.sh [options]

Options:
  -jN
  -clean
  -no_clean

EOF
}

parse_options()
{
  j_option="-j4"
  clean_option="-DNO_CLEAN"
  
  for i in $@; do
    case $i in
      -j*)
        j_option=$i
        ;;
      -clean)
        clean_option=""
        ;;
      -no_clean)
        clean_option="-DNO_CLEAN"
        ;;
      *)
        usage
        exit 1
        ;;
    esac
  done
}

build_amd64()
{
  export TARGET=amd64 TARGET_ARCH=amd64
  
  make ${j_option} ${clean_option} buildworld || exit 1
  make ${j_option} buildkernel KERNCONF="MYHW MYVIRTHW MYVIRTHW-ROUTER" || exit 1
}

build_armv6()
{
  export TARGET=arm TARGET_ARCH=armv6
  
  make ${j_option} ${clean_option} buildworld || exit 1
  make ${j_option} buildkernel KERNCONF="MYHW MYODROIDC1-ROUTER MYRPIB" || exit 1
}


cd ../../.. || exit 1
parse_options $@
# mergemaster -p
build_amd64
build_armv6
