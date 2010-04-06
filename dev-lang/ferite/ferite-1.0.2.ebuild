# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ferite/ferite-1.0.2.ebuild,v 1.13 2010/04/06 09:04:00 abcd Exp $

EAPI="3"

inherit multilib autotools

DESCRIPTION="A clean, lightweight, object oriented scripting language"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.ferite.org/"

DEPEND=">=dev-libs/libpcre-5
	dev-libs/libxml2"

SLOT="1"
LICENSE="as-is"
KEYWORDS="~alpha amd64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_prepare() {
	# use docsdir variable, install to DESTDIR
	sed -i -e '/docsdir =/!s:$(prefix)/share/doc/ferite:$(DESTDIR)$(docsdir):' \
		docs/Makefile.am || die

	# Install docs to /usr/share/doc/${PF}, not .../${PN}
	sed -i -e "s:doc/ferite:doc/${PF}:" \
		Makefile.am \
		docs/Makefile.am \
		scripts/test/Makefile.am \
		scripts/test/rmi/Makefile.am || die

	# Don't override the user's LDFLAGS
	sed -i -e 's:_LDFLAGS = :&$(AM_LDFLAGS) :' \
		-e '/^LDFLAGS/s:^:AM_:' \
		modules/*/Makefile.am \
		libs/{aphex,triton}/src/Makefile.am \
		src/Makefile.am || die

	# Only build/install shared libs for modules (can't use static anyway)
	sed -i -e '/_LDFLAGS/s:-module:& -shared:' modules/*/Makefile.am || die

	# use LIBADD to ensure proper deps (fix parellel build)
	sed -i -e '/^stream_la_LDFLAGS/s:-L\. -lferitestream::' \
		-e '/^stream_la_LIBADD/s:$:libferitestream.la:' \
		modules/stream/Makefile.am || die

	# Make sure we install in $(get_libdir), not lib
	sed -i -e "s|\$prefix/lib|\$prefix/$(get_libdir)|g" configure.ac || die

	# We copy feritedoc to ${T} in src_install, then patch it in-situ
	# note that this doesn't actually work right, currently - it still tries
	# to pull from / instead of ${D}, and I can't figure out how to fix that
	sed -i -e 's:$(prefix)/bin/:${T}/:' docs/Makefile.am || die

	eautoreconf
}

src_configure() {
	econf --libdir="${EPREFIX}"/usr/$(get_libdir)
}

src_install() {
	cp tools/doc/feritedoc "${T}"
	sed -i -e '/^prefix/s:prefix:${T}' "${T}"/feritedoc
	sed -i -e '/^$prefix/s:$prefix/bin/ferite:'"${ED}"'usr/bin/ferite:' "${T}"/feritedoc
	sed -i -e 's:$library_path $library_path:${S}/tools/doc ${S}/tools/doc:' "${T}"/feritedoc
	export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}${LD_LIBRARY_PATH:+:}${ED}usr/lib"
	emake -j1 DESTDIR="${D}" LIBDIR="${EPREFIX}"/usr/$(get_libdir) install || die
}
