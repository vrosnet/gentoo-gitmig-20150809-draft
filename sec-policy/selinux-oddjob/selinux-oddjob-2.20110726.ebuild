# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-oddjob/selinux-oddjob-2.20110726.ebuild,v 1.1 2012/01/14 19:59:58 swift Exp $
EAPI="4"

IUSE=""
MODS="oddjob"
BASEPOL="2.20110726-r10"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for oddjob"

KEYWORDS="~amd64 ~x86"
