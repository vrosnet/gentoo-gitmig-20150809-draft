# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-3.1.5.ebuild,v 1.3 2003/02/10 09:17:22 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools -ps top tload snice vmstat free w watch uptime pmap skill pkill kill pgrep sysctl"
SRC_URI="http://${PN}.sf.net/${P}.tar.gz"
HOMEPAGE="http://procps.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

RDEPEND=">=sys-libs/ncurses-5.2-r2"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.10.35"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Use the CFLAGS from /etc/make.conf.
	for file in `find . -iname "Makefile"`;do
		mv ${file} ${file}.orig
		sed -e "s:-O2:${CFLAGS}:" ${file}.orig > ${file}
	done
}

src_compile() { 
	emake || die
}

src_install() {
	einstall DESTDIR="${D}"|| die

	dodoc BUGS COPYING COPYING.LIB NEWS TODO
	docinto proc
	dodoc proc/COPYING
	docinto ps
	dodoc ps/COPYING ps/HACKING
}

pkg_postinst() {
	einfo "NOTE: By default \"ps\" and \"top\" no longer"
	einfo "show threads. You can use the '-m' flag"
	einfo "in ps or the 'H' key in top to show them"
}
