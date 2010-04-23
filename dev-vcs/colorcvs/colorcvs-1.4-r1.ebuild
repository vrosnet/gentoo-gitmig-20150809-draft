# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/colorcvs/colorcvs-1.4-r1.ebuild,v 1.2 2010/04/23 14:17:46 darkside Exp $

EAPI=3
inherit eutils prefix

DESCRIPTION="A tool based on colorgcc to beautify cvs output"
HOMEPAGE="http://www.hakubi.us/colorcvs/"
SRC_URI="http://www.hakubi.us/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
	dev-util/cvs"

src_prepare() {
	# fix typo
	sed -i -e 's:compiler_pid:cvs_pid:' ${PN} || die "sed failed"
	epatch "${FILESDIR}"/${P}-prefix.patch
	eprefixify colorcvs
}

src_install() {
	insinto /etc/profile.d
	doins "${FILESDIR}/${PN}-profile.sh" || die "doins failed"

	dobin colorcvs || die "dobin failed"
	dodoc colorcvsrc-sample || die "dodoc failed"
}

pkg_postinst() {
	einfo
	einfo "An alias to colorcvs was installed for the cvs command."
	einfo "In order to immediately activate it do:"
	einfo "\tsource /etc/profile"
	einfo
}
