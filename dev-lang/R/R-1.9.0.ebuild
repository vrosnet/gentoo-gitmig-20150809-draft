# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/R/R-1.9.0.ebuild,v 1.2 2004/04/20 11:08:54 phosphan Exp $

IUSE="atlas X tcltk gnome"

DESCRIPTION="R is GNU S - A language and environment for statistical computing and graphics."

SRC_URI="http://cran.r-project.org/src/base/${P}.tgz"

	#There are daily release patches, don't know how to utilize these
	#"ftp://ftp.stat.math.ethz.ch/Software/${PN}/${PN}-release.diff.gz"

HOMEPAGE="http://www.r-project.org/"

DEPEND="virtual/glibc
		>=dev-lang/perl-5.6.1-r3
		>=sys-libs/readline-4.1-r3
		>=sys-libs/zlib-1.1.3-r2
		>=media-libs/jpeg-6b-r2
		>=media-libs/libpng-1.2.1
		x86? ( atlas? ( dev-libs/atlas ) )
		sparc? ( atlas? ( dev-libs/atlas ) )
		~amd64? ( atlas? ( dev-libs/atlas ) )
		X? ( virtual/x11 )
		tcltk? ( dev-lang/tk )
		gnome? ( >=gnome-base/gnome-libs-1.4.1.4
			>=gnome-base/libglade-0.17
			>=dev-libs/libxml-1.8.16
			>=gnome-base/ORBit-0.5.12
			>=media-libs/imlib-1.9.10
			>=x11-libs/gtk+-1.2.10
			>=dev-libs/glib-1.2.10
			>=media-sound/esound-0.2.23
			>=media-libs/audiofile-0.2.1 )"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e 's/^#define NeedFunctionPrototypes 0/#define NeedFunctionPrototypes 1/' \
	-i src/modules/X11/dataentry.c || die "sed failed"
}

src_compile() {
	addwrite "/var/cache/fonts"
	local myconf="--enable-R-profiling --enable-R-shlib --with-readline"

	#Eventually, we will want to take into account that a user may have
	#an alternate or additional blas libraries,
	#i.e. USE variable blas and and virtual/blas
	use atlas || myconf="${myconf} --without-blas" #default enabled

	use X || myconf="${myconf} --without-x" #default enabled

	if use tcltk; then
		#configure needs to find the files tclConfig.sh and tkConfig.sh
		myconf="${myconf} --with-tcltk --with-tcl-config=/usr/lib/tclConfig.sh --with-tk-config=/usr/lib/tkConfig.sh"
	else
		myconf="${myconf} --without-tcltk"
	fi

	use gnome && myconf="${myconf} --with-gnome" #default disabled

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	make || die

}

src_install () {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "Installation Failed"

	#fix the R wrapper script to have the correct R_HOME_DIR
	#sed regexp borrowed from included debian rules
	cp ${D}/usr/lib/R/bin/R ${S}/bin/R.orig
	sed -e '/^R_HOME_DIR=.*/s::R_HOME_DIR=/usr/lib/R:' \
		${S}/bin/R.orig > ${D}/usr/lib/R/bin/R

	#R installs two identical wrappers under /usr/bin and /usr/lib/R/bin/
	#the 2nd one is corrected by above sed, for the 1st
	#I'll just symlink it into /usr/bin
	cd ${D}/usr/bin/
	rm R
	dosym ../lib/R/bin/R /usr/bin/R
	cd ${S}

	dodoc AUTHORS BUGS COPYING* ChangeLog FAQ INSTALL *NEWS README \
		RESOURCES THANKS VERSION Y2K

	#Add rudimentary menu entry if gnome
	if use gnome; then
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/R.desktop
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/R-logo.png
	fi

}
