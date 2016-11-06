#!/bin/sh


if [ ! -O ../Makefile ]; then
  echo "not in source dir or not source files' owner" 1>&2
  exit 1
fi


# -- replace_exist(relative_path) --
my_replace_exist()
{
  local my_from="tree/$1"
  local my_to="../$1"
  local my_to_orig="${my_to}.orig"
  
  echo -n "`basename $0`: $1: " 1>&2
  
  if [ ! -e "${my_to_orig}" ]; then
    mv -n "${my_to}" "${my_to_orig}" 2>/dev/null && cp -n "${my_from}" "${my_to}" 2>/dev/null
    
    if [ "$?" -ne 0 ]; then
      echo "error replacing" 1>&2
      return 1
    fi
  else
    echo "original already exists" 1>&2
    return 1
  fi
  
  echo "replaced" 1>&2
  
  return 0
}


# -- apply --
my_replace_exist bin/Makefile

my_replace_exist contrib/mtree/compare.c

my_replace_exist etc/defaults/rc.conf
my_replace_exist etc/network.subr
my_replace_exist etc/rc.d/Makefile
my_replace_exist etc/rc.d/netif
my_replace_exist etc/rc.d/var
my_replace_exist etc/termcap.small

my_replace_exist rescue/rescue/Makefile

my_replace_exist share/examples/Makefile

my_replace_exist share/man/man4/ip6.4

my_replace_exist share/man/man5/rc.conf.5

my_replace_exist share/termcap/termcap

my_replace_exist sys/kern/subr_rtc.c

my_replace_exist sys/net/route.c
my_replace_exist sys/net/route.h
my_replace_exist sys/net/rtsock.c

my_replace_exist sys/netinet6/in6.c
my_replace_exist sys/netinet6/nd6.c
my_replace_exist sys/netinet6/nd6.h
my_replace_exist sys/netinet6/nd6_nbr.c
my_replace_exist sys/netinet6/nd6_rtr.c

my_replace_exist usr.sbin/rtadvd/control.c
my_replace_exist usr.sbin/rtadvd/if.c

my_replace_exist usr.sbin/wpa/Makefile
