# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-imaze/selinux-imaze-2.20120725-r5.ebuild,v 1.1 2012/09/22 09:27:11 swift Exp $
EAPI="4"

IUSE=""
MODS="imaze"
BASEPOL="2.20120725-r5"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for imaze"

KEYWORDS="~amd64 ~x86"
