# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkimlib/ruby-gdkimlib-0.30.ebuild,v 1.1 2003/01/07 23:44:37 agriffis Exp $

S=${WORKDIR}/ruby-gnome-all-${PV}/gdkimlib
DESCRIPTION="Ruby GdkImlib bindings"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
LICENSE="Ruby"
KEYWORDS="x86 ~alpha"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.6.4-r1
		=x11-libs/gtk+-1.2*
		>=dev-ruby/ruby-gtk-${PV}"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install () {
	make site-install DESTDIR=${D}
	dodoc [A-Z]*
	cp -dr sample ${D}/usr/share/doc/${PF}
}
