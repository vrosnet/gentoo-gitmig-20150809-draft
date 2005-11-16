# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.5.0_rc1.ebuild,v 1.1 2005/11/16 10:46:38 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="doc tidy"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"

RDEPEND="${DEPEND}
	tidy? ( app-text/htmltidy )
	doc? ( app-doc/quanta-docs )"
