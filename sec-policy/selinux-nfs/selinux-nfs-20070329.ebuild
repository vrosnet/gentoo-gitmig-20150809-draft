# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nfs/selinux-nfs-20070329.ebuild,v 1.2 2007/06/04 00:26:42 pebenito Exp $

MODS="rpc"
IUSE=""

inherit selinux-policy-2

RDEPEND="sec-policy/selinux-portmap"

DESCRIPTION="SELinux policy for NFS"

KEYWORDS="alpha amd64 mips ppc sparc x86"

