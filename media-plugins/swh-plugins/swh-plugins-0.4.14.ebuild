# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/swh-plugins/swh-plugins-0.4.14.ebuild,v 1.4 2008/01/31 21:05:04 grobian Exp $

inherit flag-o-matic eutils

IUSE=""
DESCRIPTION="Large collection of LADSPA audio plugins/effects"
HOMEPAGE="http://plugin.org.uk"
SRC_URI="http://plugin.org.uk/releases/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"

DEPEND="media-libs/ladspa-sdk
	dev-util/pkgconfig
	sci-libs/fftw
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} || die

	use amd64 && append-flags -fPIC
	use ppc && append-flags -fPIC

	cd ${S}
	sed -i '/MACHINE=/s/.*/MACHINE=""/' configure
	sed -i -r  "s/(^plugindir.*)(lib)/\1$(get_libdir)/g" Makefile.in
}

src_compile() {
	econf ${myconf} || die "configure failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO || die
}

pkg_postinst() {
	ewarn "WARNING: You have to be careful when using the"
	ewarn "swh plugins. Be sure to lower your sound volume"
	ewarn "and then play around a bit with the plugins so"
	ewarn "you get a feeling for it. Otherwise your speakers"
	ewarn "won't like that."
}
