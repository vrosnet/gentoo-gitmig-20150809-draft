# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gabber/gabber-1.9.3.ebuild,v 1.2 2004/03/29 19:11:20 humpback Exp $

inherit gnome2

MY_PN="Gabber"

DESCRIPTION="The next generation of Gabber: The Gnome Jabber Client."
HOMEPAGE="http://gabber.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/gabber/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="1"
KEYWORDS="~x86"

IUSE="spell ssl"

DEPEND="sys-devel/gettext
	>=dev-cpp/gtkmm-2.0
	>=dev-cpp/gconfmm-2.0
	>=dev-cpp/libglademm-2.0
	>=net-im/jabberoo-1.9.0
	dev-util/pkgconfig
	ssl? ( dev-libs/openssl )
	spell? ( app-text/gtkspell )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}-${PV}

# This is beta code, shoul turn debug on so that messages to developers
# come with extra info
MYCONF="--enable-debug"
use ssl && MYCONF=${MYCONF} || MYCONF="${MYCONF} --disable-ssl"
use spell && MYCONF=${MYCONF} || MYCONF="${MYCONF} --disable-gtkspell"

# The configure works bad with this see bug 45758
#G2CONF="${G2CONF} $(use_enable ssl)"
#G2CONF="${G2CONF} $(use_enable spell gtkspell)" 
G2CONF="${G2CONF} ${MYCONF}"

DOCS="AUTHORS ChangeLog COPYING HACKING HACKING.ideas NEWS README TODO"
