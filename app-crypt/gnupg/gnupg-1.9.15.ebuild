# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.9.15.ebuild,v 1.2 2005/01/27 18:55:06 dragonheart Exp $

inherit eutils flag-o-matic

ECCVER=0.1.6

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gnupg/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="X caps ldap nls smartcard static threads selinux"

RDEPEND="
	!static? (
		ldap? ( net-nds/openldap )
		caps? ( sys-libs/libcap )
		sys-libs/zlib
	)
	X? ( || ( media-gfx/xloadimage media-gfx/xli ) )
	nls? ( sys-devel/gettext )
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libksba-0.9.7
	=dev-libs/libassuan-0.6.9
	smartcard? ( >=dev-libs/opensc-0.8.0 )
	sys-libs/zlib
	virtual/libc
	dev-lang/perl
	threads? ( >=dev-libs/pth-1.3.7 )
	virtual/mta
	selinux? ( sec-policy/selinux-gnupg )"

DEPEND="caps? ( sys-libs/libcap )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libksba-0.9.7
	>=dev-libs/libassuan-0.6.9
	smartcard? ( >=dev-libs/opensc-0.8.0 )
	sys-libs/zlib
	virtual/libc
	dev-lang/perl
	threads? ( >=dev-libs/pth-1.3.7 )"

src_unpack() {
	unpack ${A}
	sed -i -e 's/PIC/__PIC__/g' ${S}/intl/relocatable.c
}

src_compile() {
	local myconf=""

	if use X; then
		local viewer
		if has_version 'media-gfx/xloadimage'; then
			viewer=/usr/bin/xloadimage
		else
			viewer=/usr/bin/xli
		fi
		myconf="${myconf} --with-photo-viewer=${viewer}"
	else
		myconf="${myconf} --disable-photo-viewers"
	fi

	append-ldflags -Wl,-z,now

	econf \
		--disable-agent \
		`use_enable smartcard scdaemon` \
		`use_enable nls` \
		`use_enable ldap` \
		`use_with caps capabilities` \
		`use_enable threads` \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dosym gpg2 /usr/bin/gpg

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc ChangeLog INSTALL NEWS README THANKS TODO VERSION

	if ! use caps ; then
		fperms u+s /usr/bin/gpg2
	fi
}

pkg_postinst() {
	if ! use caps; then
		einfo "gpg is installed suid root to make use of protected memory space"
		einfo "This is needed in order to have a secure place to store your"
		einfo "passphrases, etc. at runtime but may make some sysadmins nervous."
	fi
	echo
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"
	ewarn "	THIS IS _ALPHA_ CODE, IT MAY NOT WORK CORRECTLY OR AT ALL. THERE"
	ewarn "	MAY BE UNDISCOVERED SECURITY OR DATA-LOSS ISSUES, DO NOT USE "
	ewarn "	IN A PRODUCTION ENVIRONMENT."
	ewarn ""
	ewarn "	This ebuild is provided for those who wish to experiment with this"
	ewarn "	new branch of gnupg and beta-testers, not for general purpose use"
	ewarn "	by non-developers"
	ewarn ""
	ewarn "	Please see #37109"
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"

	einfo
	einfo "gpg-agent is now provided in app-crypt/gpg-agent"

	einfo ""
	einfo "See http://www.gentoo.org/doc/en/gnupg-user.xml for documentation on gnupg"
	einfo ""
}
