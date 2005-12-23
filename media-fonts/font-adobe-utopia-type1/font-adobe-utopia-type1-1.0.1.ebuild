# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-adobe-utopia-type1/font-adobe-utopia-type1-1.0.1.ebuild,v 1.1 2005/12/23 08:58:37 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular


DESCRIPTION="BigReqs prototype headers"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~s390 ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	media-libs/fontconfig"
