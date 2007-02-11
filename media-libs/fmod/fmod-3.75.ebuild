# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fmod/fmod-3.75.ebuild,v 1.1 2007/02/11 02:41:01 hanno Exp $

MY_P="fmodapi${PV/.}linux"
S=${WORKDIR}/${MY_P}
DESCRIPTION="music and sound effects library, and a sound processing system"
HOMEPAGE="http://www.fmod.org/"
SRC_URI="http://www.fmod.org/files/${MY_P}.tar.gz"

LICENSE="fmod"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

RESTRICT="strip"

src_install() {
	dolib api/libfmod-${PV}.so
	dosym /usr/lib/libfmod-${PV}.so /usr/lib/libfmod.so

	insinto /usr/include
	doins api/inc/*

	insinto /usr/share/${PN}/media
	doins media/* || die "doins failed"
	cp -r samples "${D}/usr/share/${PN}/" || die "cp failed"

	dohtml -r documentation/*
	dodoc README.TXT documentation/Revision.txt
}
