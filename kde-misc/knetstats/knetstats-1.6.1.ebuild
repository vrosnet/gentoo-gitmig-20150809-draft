# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/knetstats/knetstats-1.6.1.ebuild,v 1.1 2006/11/27 11:43:28 deathwing00 Exp $

inherit kde

DESCRIPTION="A simple KDE network monitor that show rx/tx LEDs or numeric information about the transfer rate of any network interface in a system tray."
HOMEPAGE="http://knetstats.sourceforge.net"
SRC_URI="mirror://sourceforge/knetstats/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

need-kde 3

LANGS="bg br cs da de el es et fr ga gl it ja ka nl pl pt pt_BR ru sk sv tr"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	kde_src_unpack

	local MAKE_LANGS
	cd "${WORKDIR}/${P}/translations"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}"
	done
	rm -f ${S}/configure
	sed -i -e "s:SUBDIRS=.*:SUBDIRS=${MAKE_LANGS}:" Makefile.am
}


