#!/bin/sh

if [ "`id -u`" != "0" ]; then
  echo "sorry, this must be done as root." 1>&2
  exit 1
fi

create_packagedir()
{
  PACKAGEDIR="/usr/obj/head-r${SVN_REVISION}M-${TIMESTAMP}-${TARGET_ARCH}"
  
  if [ ! -e "${PACKAGEDIR}" ]; then
    mkdir "${PACKAGEDIR}" || exit 1
  fi
}

package_world()
{
  mkdir "${DISTDIR}" || exit 1
  env DISTDIR="${DISTDIR}" make distributeworld || exit 1
  ( cd tools/tools/guy && env DESTDIR="${DISTDIR}/base" make -m ../../../share/mk delete-optional ) || exit 1
  ( cd tools/tools/guy && env DESTDIR="${DISTDIR}/base" ./unused.sh delete ) || exit 1
  ( cd tools/tools/guy && env DESTDIR="${DISTDIR}/base" ./fix_rc_scripts.sh ) || exit 1
  env DISTDIR="${DISTDIR}" make packageworld || exit 1
  mv "${DISTDIR}"/*.txz "${PACKAGEDIR}/" || exit 1
  chflags -R noschg "${DISTDIR}" || exit 1
  rm -Rf "${DISTDIR}" || exit 1
}

package_kernels()
{
  for i in $@; do
    mkdir "${DISTDIR}" || exit 1
    env DISTDIR="${DISTDIR}" make distributekernel KERNCONF="${i}" || exit 1
    if [ "${i}" = "MYODROIDC1" -o "${i}" = "MYODROIDC1-ROUTER" ]; then
      cp /usr/obj/${TARGET}.${TARGET_ARCH}/usr/src/sys/$i/kernel.bin "${DISTDIR}/kernel/boot/kernel/" || exit 1
    fi
    ( cd "${DISTDIR}/kernel" && tar cvJf "${PACKAGEDIR}/kernel-${i}.txz" . ) || exit 1
    rm -Rf "${DISTDIR}" || exit 1
  done
}

package_amd64()
{
  export TARGET=amd64 TARGET_ARCH=amd64
  
  create_packagedir
  package_world
  package_kernels MYHW MYVIRTHW MYVIRTHW-ROUTER
}

package_armv6()
{
  export TARGET=arm TARGET_ARCH=armv6
  
  create_packagedir
  package_world
  package_kernels MYHW MYHW-ROUTER MYODROIDC1-ROUTER MYRPIB
}


cd ../../.. || exit 1

DISTDIR="${TMPDIR:-/tmp}/src-dist"
SVN_REVISION="$(svn info | awk '/^Revision:/ { print $2 }')"
TIMESTAMP=$(date +%Y%m%d)

if [ -e "${DISTDIR}" ]; then
  rm -Rf "${DISTDIR}" || exit 1
fi

package_amd64
package_armv6
