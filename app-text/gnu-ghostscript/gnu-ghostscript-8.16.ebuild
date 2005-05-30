# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnu-ghostscript/gnu-ghostscript-8.16.ebuild,v 1.1 2005/05/30 18:19:21 genstef Exp $

inherit eutils libtool

DESCRIPTION="GNU Ghostscript"
HOMEPAGE="http://www.gnu.org/software/ghostscript/"

CUPS_PV=1.1.20

SRC_URI="ftp://ftp.gnu.org/gnu/ghostscript/${P}.tar.gz
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz)
	cups? ( mirror://gentoo/cups-${CUPS_PV}-source.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="X cups cjk gtk"

PROVIDE="virtual/ghostscript"

DEPEND="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=sys-libs/zlib-1.2.0
	X? ( virtual/x11 )
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	cups? ( >=net-print/cups-1.1.20 )
	gtk? ( =x11-libs/gtk+-1.2* )
	!virtual/ghostscript
	media-fonts/gnu-gs-fonts-std"

src_unpack() {
	unpack ${P}.tar.gz

	# cups support
	if use cups; then
		unpack cups-${CUPS_PV}-source.tar.bz2
		cp -r cups-${CUPS_PV}/pstoraster ${S}
		cd ${S}/pstoraster
		sed -e 's:@prefix@:/usr:' -e 's:@exec_prefix@:${prefix}:' -e 's:@bindir@:${exec_prefix}/bin:' -e 's:@GS@:gs:' pstopxl.in > pstopxl
		sed -i -e 's:/usr/local:/usr:' pstoraster
		sed -i -e "s:pstopcl6:pstopxl:" cups.mak
		cd ..
		epatch pstoraster/gs811-lib.patch
	fi

	# enable cfax device
	sed -i -e 's:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev:DEVICE_DEVS7=$(DD)faxg3.dev $(DD)faxg32d.dev $(DD)faxg4.dev $(DD)cfax.dev:' ${S}/Makefile.in
}

src_compile() {
	myconf="--with-ijs"

	use X && myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	# don't build gtk frontend if not in use
	use gtk || sed -i -e 's:$(INSTALL_PROGRAM) $(GSSOX):#:' src/unix-dll.mak \
		-e 's:$(GSSOX)::' src/unix-dll.mak

	econf ${myconf} || die "econf failed"

	# build cups driver with cups
	if use cups; then
		echo 'include pstoraster/cups.mak' >> Makefile
		sed -i -e 's:DEVICE_DEVS17=:DEVICE_DEVS17=$(DD)cups.dev:' Makefile
		sed -i -e 's:LDFLAGS=\(.*\)$(XLDFLAGS):LDFLAGS=\1-L/usr/include -lcups -lcupsimage $(XLDFLAGS):' Makefile
	fi

	# search path fix
#	sed -i -e 's:$(gsdatadir)/lib:/usr/share/ghostscript/8.15/lib:' Makefile
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' Makefile
#	sed -i -e 's:$(gsdatadir)/Resource:/usr/share/ghostscript/8.15/Resource:' Makefile

	make || die "make failed"
	make so || die "make so failed"

	# build ijs
	cd ijs
	libtoolize --copy --force
	econf --prefix=${D}/usr || die "econf failed"
	make || die "make failed"
	cd ..
}

src_install() {
	einstall install_prefix=${D} soinstall

	rm -fr ${D}/usr/share/ghostscript/${PV}/doc || die
	dodoc doc/README
	dohtml doc/*.html doc/*.htm
	insinto /usr/share/emacs/site-lisp
	doins doc/gsdoc.el || die

	if use cjk ; then
		dodir /usr/share/ghostscript/${PV}/Resource
		dodir /usr/share/ghostscript/${PV}/Resource/Font
		dodir /usr/share/ghostscript/${PV}/Resource/CIDFont
		cd ${D}/usr/share/ghostscript/${PV}/Resource
		unpack adobe-cmaps-200204.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi

	# install ijs
	cd ${S}/ijs
	dodir /usr/bin /usr/include /usr/lib
	einstall install_prefix=${D}
}
