# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/oggtst/oggtst-0.0.ebuild,v 1.9 2003/11/29 04:37:56 brad_mssw Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A tool for calculating ogg-vorbis playing time."
SRC_URI="http://gnometoaster.rulez.org/archive/${PN}.tgz"
HOMEPAGE="http://gnometoaster.rulez.org/"

DEPEND=">=media-libs/libao-0.8.0
	>=media-libs/libvorbis-1.0_rc2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"

src_compile() {

	econf || die
	make || die
}

src_install() {

	make DESTDIR=${D} \
		install || die

	dodoc AUTHORS ChangeLog README
}
