# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.13.90.0.16-r1.ebuild,v 1.10 2003/05/25 15:34:03 mholzer Exp $

IUSE="nls bootstrap static build"

# NOTE to Maintainer:  ChangeLog states that it no longer use perl to build
#                      the manpages, but seems this is incorrect ....

inherit eutils libtool flag-o-matic

# Generate borked binaries.  Bug #6730
filter-flags "-fomit-frame-pointer -fssa"

S="${WORKDIR}/${P}"
DESCRIPTION="Tools necessary to build programs"
SRC_URI="mirror://kernel/linux/devel/binutils/${P}.tar.bz2
	mirror://kernel/linux/devel/binutils/test/${P}.tar.bz2"
HOMEPAGE="http://sources.redhat.com/binutils/"

SLOT="0"
LICENSE="GPL-2 | LGPL-2"
KEYWORDS="x86 ppc alpha sparc mips hppa"

DEPEND="virtual/glibc
	>=sys-apps/portage-2.0.21
	nls? ( sys-devel/gettext )
	|| ( dev-lang/perl 
	     ( !build?     ( dev-lang/perl ) )
	     ( !bootstrap? ( dev-lang/perl ) )
	    )"
# This is a hairy one.  Basically depend on dev-lang/perl
# if "build" or "bootstrap" not in USE.

src_unpack() {
	
	unpack ${A}

	cd ${S}
	# Various patches from Redhat/Mandrake...
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-glibc21.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-ia64-brl.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-x86_64-testsuite.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-x86_64-gotpcrel.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.16-rodata-cst.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.16-eh-frame-ro.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.16-ppc-apuinfo.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.16-stt_tls.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.16-ia64-bootstrap.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.16-tls-strip.patch
}

src_compile() {

        # Add patches for mips
        if [ "${ARCH}" = "mips" ]
        then
                cd ${S}
                chmod +x mips/README
                ./mips/README
        fi
	
	local myconf=""
	use nls && \
		myconf="${myconf} --without-included-gettext" || \
		myconf="${myconf} --disable-nls"

	# Fix /usr/lib/libbfd.la
	elibtoolize --portage

	./configure --enable-shared \
		--enable-64-bit-bfd \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		${myconf} || die
		
	if [ "`use static`" ]
	then
		make headers -C bfd CFLAGS=-O || die
		emake -e LDFLAGS=-all-static || die
	else
		make headers -C bfd CFLAGS=-O || die
		emake || die
	fi

	if [ -z "`use build`" ]
	then
		if [ -z "`use bootstrap`" ]
		then
			#nuke the manpages to recreate them (only use this if we have perl)
			find . -name '*.1' -exec rm -f {} \; || :
		fi
		#make the info pages (makeinfo included with gcc is used)
		make info || die
	fi
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	insinto /usr/include
	doins include/libiberty.h
	
	# c++filt is included with gcc -- what are these GNU people thinking?
	# but not the manpage, so leave that!
# We install it now, as gcc-3.3 do not have it any longer ...
#	rm -f ${D}/usr/bin/c++filt #${D}/usr/share/man/man1/c++filt*
	
	# By default strip has a symlink going from /usr/${CHOST}/bin/strip to
	# /usr/bin/strip we should reverse it:

	rm ${D}/usr/${CHOST}/bin/strip; mv ${D}/usr/bin/strip ${D}/usr/${CHOST}/bin/strip
	# The strip symlink gets created in the loop below
	
	# By default ar, as, ld, nm, ranlib and strip are in two places; create
	# symlinks.  This will reduce the size of the tbz2 significantly.  We also
	# move all the stuff in /usr/bin to /usr/${CHOST}/bin and create the
	# appropriate symlinks.  Things are cleaner that way.
	cd ${D}/usr/bin
	local x=""
	for x in * strip
	do
	if [ ! -e ../${CHOST}/bin/${x} ]
		then
			mv ${x} ../${CHOST}/bin/${x}
		else	
			rm -f ${x}
		fi
		ln -s ../${CHOST}/bin/${x} ${x}
	done
	
	cd ${S}
	if [ -z "`use build`" ]
	then
		make prefix=${D}/usr \
			mandir=${D}/usr/share/man \
			infodir=${D}/usr/share/info \
			install-info || die
			
		dodoc COPYING* README
		docinto bfd
		dodoc bfd/ChangeLog* bfd/COPYING bfd/README bfd/PORTING bfd/TODO
		docinto binutils
		dodoc binutils/ChangeLog binutils/NEWS binutils/README
		docinto gas
		dodoc gas/ChangeLog* gas/CONTRIBUTORS gas/COPYING gas/NEWS gas/README*
		docinto gprof
		dodoc gprof/ChangeLog* gprof/TEST gprof/TODO
		docinto ld
		dodoc ld/ChangeLog* ld/README ld/NEWS ld/TODO
		docinto libiberty
		dodoc libiberty/ChangeLog* libiberty/COPYING.LIB libiberty/README
		docinto opcodes
		dodoc opcodes/ChangeLog*
		# Install pre-generated manpages .. currently we do not ...
	else
		rm -rf ${D}/usr/share/man
	fi
}

