# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pari/pari-2.1.5-r2.ebuild,v 1.2 2004/05/04 23:26:31 kloeri Exp $

DESCRIPTION="pari (or pari-gp) : a software package for computer-aided number theory"
HOMEPAGE="http://www.parigp-home.de/"
SRC_URI="http://www.gn-50uma.de/ftp/pari-2.1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha ~mips ~hppa ~amd64"

IUSE="doc"

DEPEND="doc? ( virtual/tetex )"

src_compile() {
	./Configure \
		--host="$(echo ${CHOST} | cut -f "1 3" -d '-')" \
		--prefix=/usr \
		--miscdir=/usr/share/doc/${P} \
		--datadir=/usr/share/${P} \
		--mandir=/usr/share/man/man1 || die "./configure failed"
	addwrite "/var/lib/texmf"
	addwrite "/usr/share/texmf"
	addwrite "/var/cache/fonts"
	emake CFLAGS="${CFLAGS} -DGCC_INLINE" gp || die
	use doc || rm -rf doc/*.tex
	use doc && emake doc
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS Announce.2.1 CHANGES README TODO
}
