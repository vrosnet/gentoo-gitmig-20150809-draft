# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-xserver/selinux-xserver-2.20110726-r2.ebuild,v 1.2 2012/02/23 18:44:00 swift Exp $
EAPI="4"

IUSE=""
MODS="xserver"
BASEPOL="2.20110726-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for xserver"

KEYWORDS="amd64 x86"
