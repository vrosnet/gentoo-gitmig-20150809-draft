# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/devilspie/devilspie-0.20.2.ebuild,v 1.2 2007/03/13 14:57:04 armin76 Exp $

inherit eutils

DESCRIPTION="A Window Matching utility similar to Sawfish's Matched Windows feature"
HOMEPAGE="http://www.burtonini.com/blog/computers/devilspie"
SRC_URI="http://www.burtonini.com/computing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.9.1
	>=x11-libs/gtk+-2
	x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:\(/usr/share/doc/devilspie\):\1-${PVR}:" devilspie.1
	epatch "${FILESDIR}/${PN}-0.16-README.patch"
	cp "${FILESDIR}/SYNTAX-0.16" SYNTAX
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README NEWS SYNTAX TODO
	keepdir /etc/devilspie
}

pkg_postinst() {
	ewarn
	ewarn "Devilspie has been completely rewritten for version 0.16 and is"
	ewarn "not backward compatible with previous versions."
	ewarn "You will now have to write some s-expressions files"
	ewarn "(like in Emacs), and put them either in /etc/devilspie for"
	ewarn "system-wide configuration, or in ~/.devilspie for per-user"
	ewarn "configuration."
	ewarn
	ewarn "See /usr/share/doc/${PF}/{README,SYNTAX}.gz for details."
	ewarn
}
