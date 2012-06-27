# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-thunderbird/selinux-thunderbird-2.20120215-r1.ebuild,v 1.1 2012/06/27 20:34:01 swift Exp $
EAPI="4"

IUSE=""
MODS="thunderbird"
BASEPOL="2.20120215-r13"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for thunderbird"

KEYWORDS="~amd64 ~x86"
DEPEND=">=sec-policy/selinux-xserver-2.20120215"
RDEPEND="${DEPEND}"
