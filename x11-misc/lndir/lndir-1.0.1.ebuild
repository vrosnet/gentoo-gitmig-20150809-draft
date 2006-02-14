# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lndir/lndir-1.0.1.ebuild,v 1.4 2006/02/14 22:52:05 corsair Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org lndir utility"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
		x11-proto/xproto"
