#!/bin/sh

handle_file()
{
  if [ -f "${DESTDIR}/$1" -o -L "${DESTDIR}/$1" ]; then
    if [ $delete = 0 ]; then
      echo "${DESTDIR}/$1"
    else
      chflags noschg "${DESTDIR}/$1" 2>/dev/null
      rm -vf "${DESTDIR}/$1" || exit 1
    fi
  fi
}

handle_dir()
{
  if [ -d "${DESTDIR}/$1" ]; then
    if [ $delete = 0 ]; then
      echo "${DESTDIR}/$1"
    else
      rmdir -v "${DESTDIR}/$1" || exit 1
    fi
  fi
}


case $1 in
  check)
    delete=0
    ;;
  delete)
    delete=1
    ;;
  *)
    echo "usage: unused.sh [check|delete]" 1>&2
    exit 1
    ;;
esac

if [ $delete = 0 ]; then
  echo ">>> Checking unused files and dirs"
else
  echo ">>> Removing unused files and dirs"
fi


handle_file usr/sbin/ancontrol
handle_file usr/share/man/man8/ancontrol.8.gz

handle_file usr/sbin/ctladm
handle_file usr/share/man/man8/ctladm.8.gz
handle_file usr/sbin/ctld
handle_file usr/share/man/man8/ctld.8.gz
handle_file usr/share/man/man5/ctl.conf.5.gz
handle_file etc/rc.d/ctld
handle_file usr/bin/ctlstat
handle_file usr/share/man/man8/ctlstat.8.gz

handle_file usr/sbin/dconschat
handle_file usr/share/man/man8/dconschat.8.gz

handle_file usr/sbin/digictl
handle_file usr/share/man/man8/digictl.8.gz

handle_file usr/sbin/dumpcis
handle_file usr/share/man/man8/dumpcis.8.gz

handle_file etc/rc.d/ftp-proxy

handle_file etc/rc.d/growfs

handle_file etc/rc.d/iovctl
handle_file usr/sbin/iovctl
handle_file usr/share/man/man5/iovctl.conf.5.gz
handle_file usr/share/man/man8/iovctl.8.gz

handle_file usr/sbin/lmcconfig
handle_file usr/share/man/man8/lmcconfig.8.gz

handle_file usr/sbin/lptcontrol
handle_file usr/share/man/man8/lptcontrol.8.gz

handle_file usr/sbin/mlxcontrol
handle_file usr/share/man/man8/mlxcontrol.8.gz

handle_file etc/rc.d/pppoed
handle_file usr/libexec/pppoed
handle_file usr/share/man/man8/pppoed.8.gz

handle_file etc/rc.d/resolv

handle_file etc/rc.d/rfcomm_pppd_server
handle_file usr/sbin/rfcomm_pppd
handle_file usr/bin/rfcomm_sppd

handle_file usr/sbin/rip6query

handle_file etc/rc.d/route6d
handle_file usr/sbin/route6d
handle_file usr/share/man/man8/route6d.8.gz

handle_file etc/rc.d/sppp
handle_file sbin/spppcontrol
handle_file rescue/spppcontrol
handle_file usr/share/man/man8/spppcontrol.8.gz

handle_file etc/rc.d/stf

# wpa_supplicant rc.d script should be modified to recreate the dir
handle_dir var/run/wpa_supplicant

handle_dir var/db/pkg
handle_dir var/db/ports
# handle_dir var/db/portsnap


if [ $delete = 0 ]; then
  echo ">>> Unused files and dirs checked"
else
  echo ">>> Unused files and dirs removed"
fi
