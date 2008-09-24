# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsetmode/xsetmode-1.0.0.ebuild,v 1.11 2008/09/24 09:46:51 aballier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="set the mode for an X Input device"
KEYWORDS="amd64 arm ~mips ~ppc ~ppc64 s390 sh ~sparc x86 ~x86-fbsd"
RDEPEND="x11-libs/libXi
	x11-libs/libX11"
DEPEND="${RDEPEND}"
