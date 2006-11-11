# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/com_err/com_err-1.39.ebuild,v 1.5 2006/11/11 09:18:55 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="common error display library"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"
SRC_URI="mirror://sourceforge/e2fsprogs/e2fsprogs-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/e2fsprogs-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.39-makefile.patch
	epatch "${FILESDIR}"/${PN}-1.39-parse-types.patch
	epatch "${FILESDIR}"/${PN}-1.38-locale.patch
}

src_compile() {
	export LDCONFIG=/bin/true
	export CC=$(tc-getCC)
	export STRIP=/bin/true

	# We want to use the "bsd" libraries while building on Darwin, but while
	# building on other Gentoo/*BSD we prefer elf-naming scheme.
	local libtype
	case ${CHOST} in
		*-darwin*) libtype=bsd;;
		*)         libtype=elf;;
	esac

	econf \
		--enable-${libtype}-shlibs \
		--with-ldopts="${LDFLAGS}" \
		$(use_enable nls) \
		|| die
	emake -C lib/et || die
}

src_test() {
	make -C lib/et check || die "make check failed"
}

src_install() {
	export LDCONFIG=/bin/true
	export CC=$(tc-getCC)
	export STRIP=/bin/true

	make -C lib/et DESTDIR="${D}" install || die
	dosed '/^ET_DIR=/s:=.*:=/usr/share/et:' /usr/bin/compile_et
	dosym et/com_err.h /usr/include/com_err.h

	dolib.a lib/libcom_err.a || die "dolib.a"
	if [[ ${USERLAND} == "Darwin" ]] ; then
		dosym /usr/$(get_libdir)/libcom_err.*.dylib /usr/$(get_libdir)/libcom_err.dylib || die
	else
		dodir /$(get_libdir)
		mv "${D}"/usr/$(get_libdir)/*$(get_libname)* "${D}"/$(get_libdir)/ || die "move .so"
		gen_usr_ldscript libcom_err.so
	fi
}

pkg_postinst() {
	echo
	ewarn "PLEASE PLEASE take note of this"
	ewarn "Please make *sure* to run revdep-rebuild now"
	ewarn "Certain things on your system may have linked against a"
	ewarn "different version of com_err -- those things need to be"
	ewarn "recompiled.  Sorry for the inconvenience"
	echo
	epause 10
	ebeep
}
