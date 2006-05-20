# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/xorg-docs/xorg-docs-1.1-r1.ebuild,v 1.1 2006/05/20 07:56:39 spyderous Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org docs"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}"

IUSE="doc"

PATCHES="${FILESDIR}/${PV}-allow_manpages_only.patch"

CONFIGURE_OPTIONS="$(use_enable doc non-man-docs)
	--with-x11docdir=/usr/share/doc/${PF}"
