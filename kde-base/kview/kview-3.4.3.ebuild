# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kview/kview-3.4.3.ebuild,v 1.2 2005/11/24 13:45:40 gustavoz Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kde image viwer"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
