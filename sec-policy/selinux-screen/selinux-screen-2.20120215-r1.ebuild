# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-screen/selinux-screen-2.20120215-r1.ebuild,v 1.1 2012/06/27 20:34:05 swift Exp $
EAPI="4"

IUSE=""
MODS="screen"
BASEPOL="2.20120215-r13"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for screen"

KEYWORDS="~amd64 ~x86"
