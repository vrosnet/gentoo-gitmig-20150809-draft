# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kandy/kandy-3.4.3.ebuild,v 1.4 2005/11/25 11:13:04 cryos Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Communicating with your mobile phone"
KEYWORDS="~alpha amd64 ~ppc ppc64 sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)"
OLDDEPEND="~kde-base/libkdepim-$PV"

KMCOPYLIB="
	libkdepim libkdepim"
KMEXTRACTONLY="
	libkdepim/ "
