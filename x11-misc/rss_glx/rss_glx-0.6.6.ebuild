# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rss_glx/rss_glx-0.6.6.ebuild,v 1.1 2002/11/22 18:22:30 vapier Exp $

DESCRIPTION="OpenGL screensavers, ported to GLX.  Suitable for use with xscreensaver."
HOMEPAGE="http://rss-glx.sourceforge.net/"
SRC_URI="mirror://sourceforge/rss-glx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="x11-base/xfree"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README README.xscreensaver
}

pkg_postinst(){
	echo
	einfo "Read /usr/share/doc/${PF}/README.xscreensaver.gz for"
	einfo "entries to add to your ~/.xscreensaver file to enable these hacks"
	echo
}
