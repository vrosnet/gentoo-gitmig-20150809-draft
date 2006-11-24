# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/telepathy-python/telepathy-python-0.13.7.ebuild,v 1.1 2006/11/24 15:40:56 peper Exp $

inherit distutils

DESCRIPTION="Telepathy Python package containing base classes for use in connection managers, and proxy classes for use in clients."
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( >=dev-python/dbus-python-0.71
	( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.34 ) )"

RDEPEND="${DEPEND}"

pkg_setup() {
	if has_version "<sys-apps/dbus-0.90"; then
		if ! built_with_use sys-apps/dbus python; then
			eerror "You need to build dbus with USE=python."
			die "dbus needs python bindings"
		fi
	fi
}
