# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXxf86misc/libXxf86misc-1.0.3.ebuild,v 1.4 2010/12/25 20:34:04 fauli Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Xxf86misc library"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-proto/xproto
	x11-proto/xextproto
	x11-proto/xf86miscproto"
DEPEND="${RDEPEND}"
