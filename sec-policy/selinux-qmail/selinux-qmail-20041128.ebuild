# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-qmail/selinux-qmail-20041128.ebuild,v 1.2 2007/07/11 02:56:47 mr_bones_ Exp $

inherit selinux-policy

TEFILES="qmail.te"
FCFILES="qmail.fc"
IUSE=""

DESCRIPTION="SELinux policy for qmail"

KEYWORDS="x86 ppc sparc amd64"
