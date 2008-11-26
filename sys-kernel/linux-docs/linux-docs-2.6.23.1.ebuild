# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-docs/linux-docs-2.6.23.1.ebuild,v 1.2 2008/11/26 23:06:25 mpagano Exp $

inherit toolchain-funcs

MY_P=linux-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Developer documentation generated from the Linux kernel"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="mirror://kernel/linux/kernel/v2.6/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

IUSE="html"
DEPEND="app-text/docbook-sgml-utils
		app-text/xmlto
		sys-apps/sed
		~app-text/docbook-xml-dtd-4.1.2"
RDEPEND=""

src_unpack() {
	unpack ${A}

	sed -i \
		-e "s:db2:docbook2:g" \
		-e "s:/usr/local/man:${D}/usr/share/man:g" \
		"${S}"/Documentation/DocBook/Makefile

	sed -i \
		-e "s:\$(Q)\$(MAKE) \$(build)=Documentation\/DocBook \$@:+\$(Q)\$(MAKE) \$(build)=Documentation\/DocBook \$@:" \
		"${S}"/Makefile

	# fix for arch change i386->x86
	ln -s "${S}"/arch/i386 "${S}"/arch/x86
}

src_compile() {
	local ARCH=$(tc-arch-kernel)
	unset KBUILD_OUTPUT

	emake mandocs || die "make mandocs failed"

	if use html; then
		emake htmldocs || die "make htmldocs failed"
	fi
}

src_install() {
	local file
	local ARCH=$(tc-arch-kernel)
	unset KBUILD_OUTPUT

	make installmandocs || die "make installmandocs failed"

	if use html; then
		for file in Documentation/DocBook/*.html; do
			dohtml -r ${file/\.html/}
		done
	fi
}
