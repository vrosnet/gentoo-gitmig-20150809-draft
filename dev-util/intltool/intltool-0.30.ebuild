# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.30.ebuild,v 1.10 2004/05/30 23:42:09 leonardop Exp $

inherit gnome.org

DESCRIPTION="Scripts for extracting translatable strings from various sourcefiles"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64"

DEPEND=">=dev-lang/perl-5.6.0"
RDEPEND="dev-perl/XML-Parser
	${DEPEND}"

src_install() {
	einstall || die "installation failed"
	dodoc AUTHORS ChangeLog NEWS README TODO INSTALL doc/I18N-HOWTO
}
