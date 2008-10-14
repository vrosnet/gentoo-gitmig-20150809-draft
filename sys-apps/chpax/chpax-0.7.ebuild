# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/chpax/chpax-0.7.ebuild,v 1.13 2008/10/14 14:47:14 flameeyes Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Manages various PaX related flags for ELF32, ELF64, and a.out binaries."
HOMEPAGE="http://pax.grsecurity.net/"
SRC_URI="http://pax.grsecurity.net/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/^CFLAGS/s:=:+=:' \
		-e '/TARGET/s:CFLAGS:LDFLAGS:' \
		"${S}"/Makefile || die "sed in Makefile failed"
}

src_compile() {
	# use static && append-ldflags -static	; # breaks with current ssp.
	emake CC="$(tc-getCC)" || die "Parallel Make Failed"
}

src_install() {
	into /
	dosbin chpax || die
	fperms 711 /sbin/chpax

	dodoc Changelog README
	doman chpax.1

	#insinto /etc/conf.d
	#newins ${FILESDIR}/pax-conf.d chpax
	#exeinto /etc/init.d
	#newexe ${FILESDIR}/pax-init.d chpax
}

pkg_postinst() {
	ewarn "chpax is now obsolete in favor of sys-apps/paxctl which uses PT_PAX_FLAGS"
	ewarn "Please use paxctl from now on. Any bugs filed for chpax will be closed as WONTFIX"
}
