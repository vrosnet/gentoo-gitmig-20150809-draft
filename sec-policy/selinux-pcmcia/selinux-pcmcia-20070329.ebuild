# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-pcmcia/selinux-pcmcia-20070329.ebuild,v 1.1 2007/03/29 23:37:50 pebenito Exp $

IUSE=""

MODS="pcmcia"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for PCMCIA card services"

KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
