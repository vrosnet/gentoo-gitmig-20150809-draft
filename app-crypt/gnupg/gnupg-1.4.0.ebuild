# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.4.0.ebuild,v 1.1 2004/12/19 03:19:32 dragonheart Exp $

inherit eutils flag-o-matic

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gnupg/${P}.tar.bz2
	idea? ( ftp://ftp.gnupg.dk/pub/contrib-dk/idea.c.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc-macos ~s390 ~sparc ~x86 ~ia64 ~mips ~ppc64"
IUSE="X ldap nls smartcard readline caps zlib idea bzip2 selinux"
#static not working yet

#!static? (
#			ldap? ( net-nds/openldap )
#			bzip2? ( app-arch/bzip2 )
#			zlib? ( sys-libs/zlib )
#		)

RDEPEND="
	ldap? ( net-nds/openldap )
	bzip2? ( app-arch/bzip2 )
	zlib? ( sys-libs/zlib )
	!X? ( media-gfx/xloadimage media-gfx/xli )
	nls? ( sys-devel/gettext )
	smartcard? ( dev-libs/libusb )
	virtual/libc
	readline? ( sys-libs/readline )"

# 	dev-lang/perl
#	virtual/mta


DEPEND="ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	zlib? ( sys-libs/zlib )
	bzip2? ( app-arch/bzip2 )
	smartcard? ( dev-libs/libusb )
	dev-lang/perl
	virtual/libc"

src_unpack() {
	unpack ${A}
	# Please read http://www.gnupg.org/why-not-idea.html
	if use idea; then
		mv ${WORKDIR}/idea.c ${S}/cipher/idea.c || \
			ewarn "failed to insert IDEA module"
	fi
}

src_compile() {
	# Certain sparc32 machines seem to have trouble building correctly with 
	# -mcpu enabled.  While this is not a gnupg problem, it is a temporary
	# fix until the gcc problem can be tracked down.
	if [ "${ARCH}" == "sparc" ] && [ "${PROFILE_ARCH}" == "sparc" ]; then
		filter-flags -mcpu=supersparc -mcpu=v8 -mcpu=v7
	fi

	# `USE=static` support was requested in #29299
	# use static && append-ldflags -static

	# Still needed?
	# Bug #6387, --enable-m-guard causes bus error on sparcs
	use sparc || myconf="${myconf} --enable-m-guard"

	if ! use zlib; then
		myconf="${myconf} --with-included-zlib"
	else
		myconf="${myconf} --without-included-zlib"
	fi

	use ppc-macos || append-ldflags -Wl,-z,now

	if use ppc-macos && use caps; then
		eerror "Capabilities support is only available for Linux."
	fi

	econf \
		`use_enable X photo-viewers` \
		`use_enable ldap` \
		--enable-mailto \
		--enable-hkp \
		--enable-finger \
		`use_enable nls` \
		`use_enable bzip2` \
		`use_enable smartcard card-support` \
		`use_enable selinux selinux-support` \
		`use_enable x86 asm` \
		`use_with caps capabilities` \
		`use_with readline` \
		--enable-static-rnd=linux \
		--libexecdir=/usr/lib \
		--enable-sha512 \
		${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} libexecdir="/usr/lib/gnupg" install || die

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS PROJECTS README THANKS \
		TODO VERSION doc/{FAQ,HACKING,DETAILS,ChangeLog,OpenPGP,faq.raw}

	docinto sgml
	dodoc doc/*.sgml

	dohtml doc/faq.html
}

