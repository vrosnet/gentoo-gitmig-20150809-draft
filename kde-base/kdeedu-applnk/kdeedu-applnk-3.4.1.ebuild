# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu-applnk/kdeedu-applnk-3.4.1.ebuild,v 1.2 2005/05/26 17:14:25 danarmak Exp $
KMNAME=kdeedu
KMMODULE=applnk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="applnk files for kdeedu-derived apps"
KEYWORDS="~x86 ~amd64 ~ppc64 ~ppc ~sparc"
IUSE=""
DEPEND=""

