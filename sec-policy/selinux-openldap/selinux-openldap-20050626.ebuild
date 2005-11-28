# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-openldap/selinux-openldap-20050626.ebuild,v 1.2 2005/11/28 09:14:31 kaiowas Exp $

inherit selinux-policy

TEFILES="slapd.te"
FCFILES="slapd.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for OpenLDAP server"

KEYWORDS="amd64 mips ppc sparc x86"

