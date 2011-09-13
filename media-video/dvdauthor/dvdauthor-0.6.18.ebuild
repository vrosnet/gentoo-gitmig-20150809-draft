# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdauthor/dvdauthor-0.6.18.ebuild,v 1.1 2011/09/13 00:32:27 beandog Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Tools for generating DVD files to be played on standalone DVD players"
HOMEPAGE="http://dvdauthor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="media-libs/libdvdread
	>=media-gfx/imagemagick-5.5.7.14
	>=dev-libs/libxml2-2.6.0
	media-libs/freetype
	dev-libs/fribidi
	media-libs/libpng"

S="${WORKDIR}/${PN}"

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README TODO ChangeLog AUTHORS
}
