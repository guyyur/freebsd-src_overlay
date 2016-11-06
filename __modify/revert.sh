#!/bin/sh


if [ ! -O ../Makefile ]; then
  echo "not in source dir or not source files' owner" 1>&2
  exit 1
fi


# revert_exist(relative_path)
my_revert_exist()
{
  local my_to="../$1"
  local my_to_orig="${my_to}.orig"
  
  echo -n "`basename $0`: $1: " 1>&2
  
  if [ -e "${my_to_orig}" ]; then
    mv -f "${my_to_orig}" "${my_to}" 2>/dev/null
    
    if [ "$?" -ne 0 ]; then
      echo "error reverting" 1>&2
      return 1
    fi
  else
    echo "original doesn't exist" 1>&2
    return 1
  fi
  
  echo "reverted" 1>&2
  
  return 0
}


# -- revert --
my_revert_exist usr.sbin/wpa/Makefile

my_revert_exist usr.sbin/rtadvd/if.c
my_revert_exist usr.sbin/rtadvd/control.c

my_revert_exist sys/netinet6/nd6_rtr.c
my_revert_exist sys/netinet6/nd6_nbr.c
my_revert_exist sys/netinet6/nd6.h
my_revert_exist sys/netinet6/nd6.c
my_revert_exist sys/netinet6/in6.c

my_revert_exist sys/net/rtsock.c
my_revert_exist sys/net/route.h
my_revert_exist sys/net/route.c

my_revert_exist sys/kern/subr_rtc.c

my_revert_exist share/termcap/termcap

my_revert_exist share/man/man5/rc.conf.5

my_revert_exist share/man/man4/ip6.4

my_revert_exist share/examples/Makefile

my_revert_exist rescue/rescue/Makefile

my_revert_exist etc/termcap.small
my_revert_exist etc/rc.d/var
my_revert_exist etc/rc.d/netif
my_revert_exist etc/rc.d/Makefile
my_revert_exist etc/network.subr
my_revert_exist etc/defaults/rc.conf

my_revert_exist contrib/mtree/compare.c

my_revert_exist bin/Makefile
