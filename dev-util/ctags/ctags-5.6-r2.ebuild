# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctags/ctags-5.6-r2.ebuild,v 1.4 2008/03/26 18:43:41 hawking Exp $

inherit eutils

DESCRIPTION="Exuberant Ctags creates tags files for code browsing in editors"
HOMEPAGE="http://ctags.sourceforge.net"
SRC_URI="mirror://sourceforge/ctags/${P}.tar.gz
	ada? ( mirror://sourceforge/gnuada/ctags-ada-mode-4.3.3.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="ada"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-ebuilds.patch"
	#epatch "${FILESDIR}/${P}-haskell.patch"
	#epatch "${FILESDIR}/${P}-objc.patch"
	epatch "${FILESDIR}/${P}-php5.patch"

	# enabling Ada support
	if use ada; then
		cp ${WORKDIR}/ctags-ada-mode-4.3.3/ada.c "${S}"
		epatch "${FILESDIR}/${PN}-ada.patch"
	fi
}

src_compile() {
	econf \
		--with-posix-regex \
		--without-readlib \
		--disable-etags \
		--enable-tmpdir=/tmp \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	# namepace collision with X/Emacs-provided /usr/bin/ctags -- we
	# rename ctags to exuberant-ctags (Mandrake does this also).
	mv "${D}"/usr/bin/{ctags,exuberant-ctags}
	mv "${D}"/usr/share/man/man1/{ctags,exuberant-ctags}.1

	dodoc FAQ NEWS README
	dohtml EXTENDING.html ctags.html
}
