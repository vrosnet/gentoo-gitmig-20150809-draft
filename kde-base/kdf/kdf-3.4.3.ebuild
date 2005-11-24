# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdf/kdf-3.4.3.ebuild,v 1.2 2005/11/24 13:52:18 gustavoz Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE free disk space utility"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
