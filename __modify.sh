#!/bin/sh


# -- check running in src dir --
if [ ! -O Makefile ]; then
  echo "not in source dir or not source files' owner" 1>&2
  exit 1
fi


# -- replace(relative_path) --
my_replace()
{
  local my_from="$1.modified"
  local my_to="$1"
  local my_to_orig="${my_to}.orig"
  
  echo -n "`basename $0`: $1: " 1>&2
  
  if [ ! -e "${my_to_orig}" ]; then
    mv -n "${my_to}" "${my_to_orig}" 2>/dev/null
    if [ "$?" -ne 0 ]; then
      echo "error backuping orig" 1>&2
      return 1
    fi
    
    cp -pn "${my_from}" "${my_to}" 2>/dev/null
    
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


# -- restore(relative_path) --
my_restore()
{
  local my_to="$1"
  local my_to_orig="${my_to}.orig"
  
  echo -n "`basename $0`: $1: " 1>&2
  
  if [ -e "${my_to_orig}" ]; then
    mv -f "${my_to_orig}" "${my_to}" 2>/dev/null
    if [ "$?" -ne 0 ]; then
      echo "error restoring original" 1>&2
      return 1
    fi
  else
    echo "original doesn't exist" 1>&2
    return 1
  fi
  
  echo "restored" 1>&2
  
  return 0
}


# --
my_list="
  bin/Makefile
  contrib/mtree/compare.c
  etc/defaults/rc.conf
  etc/network.subr
  etc/rc.d/Makefile
  etc/rc.d/netif
  etc/rc.d/var
  etc/termcap.small
  sbin/route/keywords
  sbin/route/route.8
  sbin/route/route.c
  share/examples/Makefile
  share/man/man4/ip6.4
  share/man/man5/rc.conf.5
  share/termcap/termcap
  sys/arm/allwinner/if_awg.c
  sys/kern/subr_clock.c
  sys/net/route.h
  sys/net/rtsock.c
  sys/netinet/if_ether.c
  sys/netinet6/in6.c
  sys/netinet6/in6_ifattach.c
  sys/netinet6/nd6.c
  sys/netinet6/nd6.h
  sys/netinet6/nd6_nbr.c
  sys/netinet6/nd6_rtr.c
  usr.bin/netstat/netstat.1
  usr.bin/netstat/route.c
  usr.sbin/arp/arp.4
  usr.sbin/ppp/route.c
  usr.sbin/route6d/route6d.c
  usr.sbin/rtadvd/control.c
  usr.sbin/rtadvd/if.c
  usr.sbin/wpa/Makefile
  "

# --
case $1 in
  replace)
    for i in $my_list; do
      my_replace "$i"
    done
    ;;
  restore)
    for i in $my_list; do
      my_restore "$i"
    done
    ;;
  compare)
    for i in $my_list; do
      diff -Nudrp "$i.modified" "$i" | less -c
    done
    ;;
  *)
    echo "usage: $0 [replace|restore|compare]" 1>&2
    exit 1
    ;;
esac
