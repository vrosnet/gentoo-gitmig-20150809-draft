# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Imaging-py21/Imaging-py21-1.1.4.ebuild,v 1.6 2004/04/26 01:23:18 agriffis Exp $

PYTHON_SLOT_VERSION="2.1"

inherit distutils eutils
P_NEW="${PN%-py21}-${PV}"
S="${WORKDIR}/${P_NEW}"

DESCRIPTION="Python Imaging Library (PIL)."
HOMEPAGE="http://www.pythonware.com/products/pil/index.htm"
SRC_URI="http://www.effbot.org/downloads/${P_NEW}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
IUSE="tcltk"

DEPEND=">=media-libs/jpeg-6a
	>=sys-libs/zlib-0.95
	tcltk? ( dev-lang/tk )"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/Imaging-1.1.4-setup.py.patch
}

src_compile() {
	export OPT=${CFLAGS}

	#Build the core imaging library (libImaging.a)
	cd ${S}/libImaging
	econf || die "econf failed"
	cp Makefile Makefile.orig

	#Not configured by configure
	sed \
		-e "s:\(JPEGINCLUDE=[[:blank:]]*/usr/\)local/\(include\).*:\1\2:" \
	Makefile.orig > Makefile
	emake || die
	cd ${S}; distutils_src_compile
	#cd ${S}
	#CFLAGS="$(CFLAGS) -DUSE_COMPOSITELESS_PHOTO_PUT_BLOCK" distutils_src_compile
}

src_install() {
	local mydoc="CHANGES* CONTENTS"
	distutils_src_install
	distutils_python_version

	# install headers required by media-gfx/sketch
	insinto "${ROOT}/usr/include/python${PYVER}"
	doins libImaging/Imaging.h
	doins libImaging/ImPlatform.h
	doins libImaging/ImConfig.h
}
