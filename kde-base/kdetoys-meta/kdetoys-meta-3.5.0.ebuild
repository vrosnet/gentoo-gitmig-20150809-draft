# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys-meta/kdetoys-meta-3.5.0.ebuild,v 1.5 2005/12/17 15:51:13 corsair Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdetoys - merge this to pull in all kdetoys-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/amor)
$(deprange $PV $MAXKDEVER kde-base/eyesapplet)
$(deprange $PV $MAXKDEVER kde-base/fifteenapplet)
$(deprange $PV $MAXKDEVER kde-base/kmoon)
$(deprange $PV $MAXKDEVER kde-base/kodo)
$(deprange $PV $MAXKDEVER kde-base/kteatime)
$(deprange $PV $MAXKDEVER kde-base/ktux)
$(deprange $PV $MAXKDEVER kde-base/kweather)
$(deprange $PV $MAXKDEVER kde-base/kworldwatch)
"
