# $FreeBSD: head/usr.sbin/wpa/Makefile 288266M $

.include <src.opts.mk>

SUBDIR= wpa_supplicant wpa_cli wpa_passphrase
SUBDIR+= hostapd hostapd_cli

.if ${MK_NDIS} != "no"
SUBDIR+= ndis_events
.endif

SUBDIR_PARALLEL=

.include <bsd.subdir.mk>
