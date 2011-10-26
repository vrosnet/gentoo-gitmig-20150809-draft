# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libraw/libraw-0.14.3.ebuild,v 1.1 2011/10/26 21:27:12 radhermit Exp $

EAPI="4"

inherit eutils autotools-utils

MY_P="LibRaw-${PV}"
DESCRIPTION="LibRaw is a library for reading RAW files obtained from digital photo cameras"
HOMEPAGE="http://www.libraw.org/"
SRC_URI="http://www.libraw.org/data/${MY_P}.tar.gz
	demosaic? (	http://www.libraw.org/data/LibRaw-demosaic-pack-GPL2-${PV}.tar.gz
		http://www.libraw.org/data/LibRaw-demosaic-pack-GPL3-${PV}.tar.gz )"

# Libraw also has it's own license, which is a pdf file and
# can be obtained from here:
# http://www.libraw.org/data/LICENSE.LibRaw.pdf
LICENSE="LGPL-2.1 CDDL GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="demosaic examples jpeg2k +lcms +openmp static-libs"

RDEPEND="jpeg2k? ( media-libs/jasper )
	lcms? ( media-libs/lcms:2 )"
DEPEND="${RDEPEND}
	openmp? ( sys-devel/gcc[openmp] )
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

DOCS=( Changelog.txt README )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.13.4-docs.patch
	eautomake
}

src_configure() {
	econf \
		$(use_enable demosaic demosaic-pack-gpl2) \
		$(use_enable demosaic demosaic-pack-gpl3) \
		$(use_enable examples) \
		$(use_enable jpeg2k jasper) \
		$(use_enable lcms) \
		$(use_enable openmp) \
		$(use_enable static-libs static)
}
