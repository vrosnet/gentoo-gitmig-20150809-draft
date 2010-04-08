# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xxkb/xxkb-1.11-r1.ebuild,v 1.1 2010/04/08 20:17:02 phosphan Exp $

inherit eutils

DESCRIPTION="eXtended XKB - assign different keymaps to different windows"
HOMEPAGE="http://sourceforge.net/projects/xxkb/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="svg"

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXpm
	svg? ( >=dev-libs/glib-2
		>=x11-libs/gtk+-2
		gnome-base/librsvg )"
DEPEND="${RDEPEND}
	app-text/rman
	x11-misc/imake
	svg? ( dev-util/pkgconfig )"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir flags
	epatch "${FILESDIR}/svg-flags.patch"
	use svg && epatch "${FILESDIR}/svg-appdefaults.patch"
}

src_compile() {
	local myconf
	use svg && myconf="-DWITH_SVG_SUPPORT"
	xmkmf ${myconf} || die "xmkmf failed."
	emake CDEBUGFLAGS="${CFLAGS}" EXTRA_LIBRARIES="-lXext" PROJECTROOT=/usr \
			PIXMAPDIR=/usr/share/xxkb || die "emake failed."
}

src_install() {
	local myopts
	if use svg; then
		myopts="PIXMAPS=flags/de.svg flags/pl.svg flags/il.svg flags/by.svg \
		flags/ua.svg flags/su.svg flags/ru.svg flags/bg.svg flags/en.svg"
	else
		myopts="FOOBAR=buzz"
	fi
	emake "${myopts}"  DESTDIR="${D}" install || die "emake install failed"
	emake DESTDIR="${D}" install.man || die "emake install.man failed"

	insinto /usr/share/xxkb
	use svg || doins "${FILESDIR}"/*.xpm
	dodoc README* CHANGES*
}
