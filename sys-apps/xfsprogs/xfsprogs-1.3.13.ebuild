# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xfsprogs/xfsprogs-1.3.13.ebuild,v 1.1 2001/11/17 07:35:22 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="xfs filesystem utilities"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/latest/cmd_tars/${P}.src.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/xfs"

DEPEND="virtual/glibc sys-devel/autoconf sys-devel/make sys-apps/e2fsprogs"
RDEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	export OPTIMIZER="${CFLAGS}"
	export DEBUG=-DNDEBUG
	autoconf || die
	./configure --prefix=/usr || die
	# 1) add a ${DESTDIR} prefix to all install paths so we can relocate during the "install" phase
	# 2) we also set the /usr/share/doc/ directory to the correct value.
	# 3) we remove a hard-coded "-O1"
	cp include/builddefs include/builddefs.orig
	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' -e "s:/usr/share/doc/xfsprogs:/usr/share/doc/${PF}:" -e 's:-O1::' include/builddefs.orig > include/builddefs || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
