# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/pybliographer/pybliographer-1.2.9.ebuild,v 1.1 2006/07/18 17:02:29 nattfodd Exp $

inherit gnome2 eutils

DESCRIPTION="Pybliographer is a tool for working with bibliographic databases"
HOMEPAGE="http://pybliographer.org/"
SRC_URI="mirror://sourceforge/pybliographer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

# gnome2.eclass
USE_DESTDIR=1
DOCS="AUTHORS ChangeLog* NEWS TODO README"

DEPEND="virtual/python
	>=dev-libs/glib-2
	>=app-text/recode-3.6-r1
	>=dev-python/gnome-python-2
	>=dev-python/python-bibtex-1.2.2
	app-text/scrollkeeper"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2.4-gentoo.diff
}

src_install() {
	# fix for access violation due to eclass change
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
}
