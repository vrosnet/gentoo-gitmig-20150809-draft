# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/air/air-1.2.5-r1.ebuild,v 1.4 2004/12/04 06:27:54 dragonheart Exp $

inherit eutils

DESCRIPTION="A GUI front-end to dd/dcfldd"
HOMEPAGE="http://air-imager.sourceforge.net/"
SRC_URI="mirror://sourceforge/air-imager/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-perl/perl-tk-804.027
	app-arch/sharutils
	sys-apps/sed
	dev-lang/perl"

RDEPEND="app-arch/mt-st
	dev-lang/perl
	sys-apps/coreutils"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-installfix.patch
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {

	PERLTK_VER=`best_version dev-perl/perl-tk`
	export PERLTK_VER=${PERLTK_VER:17}

	env INTERACTIVE=no INSTALL_DIR=${D}/usr TEMP_DIR=${T} \
		FINAL_INSTALL_DIR=/usr \
		./install-${P} \
		|| die "failed to install - please attach ${T}/air-install.log to a bug report at http://bugs.gentoo.org"

	dodoc README

	dodoc ${T}/air-install.log

	rm ${D}/usr/bin/split

	chown -R root:root ${D}
	fowners root:users /usr/share/air/logs
	fperms ug+rwx /usr/share/air/logs
	if [ -p ${D}usr/share/air/air-fifo ]; then
		fperms ug+rw /usr/share/air/air-fifo
		fowners root:users /usr/share/air/air-fifo
	fi
	fperms a+x /usr/bin/air
}

pkg_postinst() {
	einfo "This will use programs from the following packages if installed:"
	einfo "sys-apps/dcfldd"
	einfo "net-analyzer/netcat"
	einfo "net-analyzer/cryptcat"

	einfo "The author, steve@unixgurus.com, would appreciate and email of the install file /usr/share/doc/${PF}/air=install.log"
}
