# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmorgan/gmorgan-0.25-r1.ebuild,v 1.8 2009/08/01 06:28:47 ssuominen Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="gmorgan is an opensource software rhythm station."
HOMEPAGE="http://gmorgan.sourceforge.net/"
SRC_URI="mirror://sourceforge/gmorgan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/fltk-1.1.2:1.1
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}/${PN}-amd64.patch"
	rm -f m4/gettext.m4 m4/inttypes_h.m4 m4/lib-ld.m4 m4/lib-link.m4 m4/lib-prefix.m4 m4/nls.m4 m4/progtest.m4 m4/stdint_h.m4 m4/uintmax_t.m4 m4/po.m4 || die "failed to remove gettext m4"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README
}
