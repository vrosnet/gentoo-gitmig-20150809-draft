# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-base-policy/selinux-base-policy-20031010.ebuild,v 1.2 2003/10/10 20:34:22 pebenito Exp $

IUSE=""

DESCRIPTION="Gentoo base policy for SELinux"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND=""
RDEPEND="sys-devel/m4
	 sys-devel/make"

S=${WORKDIR}/base-policy

[ -z ${POLICYDIR} ] && POLICYDIR="/etc/security/selinux/src/policy"

src_install() {
	dodir /etc/security/selinux/src

	insinto /etc/security
	doins ${S}/appconfig/*

	cp -a ${S} ${D}/${POLICYDIR}
	rm -fR ${D}/${POLICYDIR}/appconfig
}

pkg_postinst() {
	echo
	einfo "This is the base policy for SELinux on Gentoo.  This policy"
	einfo "package only covers the applications in the system profile."
	einfo "More policy may need to be added according to your requirements."
	echo
	eerror "It is STRONGLY suggested that you evaluate and merge the"
	eerror "policy changes.  If any of the file contexts (*.fc) have"
	eerror "changed, you should also relabel."
	echo
	ewarn "Please check the Changelog, there may be important information."
	echo
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 ; echo -ne "\a" ; sleep 1
	sleep 8
}
