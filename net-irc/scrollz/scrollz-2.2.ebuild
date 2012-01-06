# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/scrollz/scrollz-2.2.ebuild,v 1.3 2012/01/06 10:48:57 ago Exp $

EAPI=4

inherit eutils toolchain-funcs

MY_P=ScrollZ-${PV}

DESCRIPTION="Advanced IRC client based on ircII"
HOMEPAGE="http://scrollz.com/"
SRC_URI="http://www.scrollz.com/download/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="gmp gnutls ipv6 socks5 ssl"

REQUIRED_USE="gnutls? ( ssl )"

RDEPEND="sys-libs/ncurses
	gmp? ( dev-libs/gmp )
	ssl? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( dev-libs/openssl )
		)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-cppflags.patch
	epatch "${FILESDIR}"/${P}-make-install.patch
}

src_configure() {
	local _myssl

	if use ssl; then
		if use gnutls; then
			_myssl="--with-ssl"
		else
			_myssl="--with-openssl"
		fi
	fi

	tc-export CC #397441, ancient autoconf
	econf \
		--with-default-server=irc.gentoo.org \
		$(use_enable socks5) \
		$(use_enable ipv6) \
		--enable-regexp \
		$(use_enable gmp fish) \
		${_myssl}
}

src_install() {
	emake \
		DESTDIR="${D}" \
		mandir="${EPREFIX}/usr/share/man/man1" \
		install

	dodoc ChangeLog* NEWS README* todo
}
