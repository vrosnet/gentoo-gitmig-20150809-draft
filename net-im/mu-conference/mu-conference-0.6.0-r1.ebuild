# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/mu-conference/mu-conference-0.6.0-r1.ebuild,v 1.1 2004/04/08 02:10:07 humpback Exp $

DESCRIPTION="Jabber Multi-User Chat"
HOMEPAGE="http://mu-conference.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/mu-conference/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=net-im/jabberd-1.4.3-r3
		>=dev-libs/glib-2.2.1"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/mu-conference-makefile.patch
}

src_compile() {
	emake || die
}

src_install() {
	dodir /etc/jabber /usr/lib/jabberd /var/log/jabber/conference
	keepdir ${D}/var/log/jabber/conference/

	insinto /usr/lib/jabberd
	doins src/mu-conference.so

	insinto /etc/jabber
	doins  ${FILESDIR}/muctrans.xml

	exeinto /etc/init.d
	newexe ${FILESDIR}/muc-transport.init muc-transport

	dodoc README FAQ README.jcr ${FILESDIR}/README.Gentoo

	fowners jabber:jabber /var/log/jabber/conference

	fperms g-x /var/log/jabber/conference

	fperms g+rw /var/log/jabber/conference
}

pkg_postinst() {
	einfo
	einfo "Please read /usr/share/doc/${P}/README.Gentoo.gz"
	einfo "And please notice that now muc-transport comes with a init.d script"
	einfo "dont forget to add it to your runlevel."
	einfo
}

