# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.0-r2.ebuild,v 1.3 2002/07/11 06:30:56 drobbins Exp $

A=lib-compat.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Compatibility c++ and libc5 libraries for programs new and old"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/${A}"
KEYWORDS="x86"
SLOT="0"

DEPEND=""

src_unpack () {
  mkdir ${S}
  cd ${S}
  unpack ${A}
}


src_install() {

    into /usr
    dolib.so *.so*
    preplib /usr

}



