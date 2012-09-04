# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-runtime/plasma-runtime-4.9.1.ebuild,v 1.1 2012/09/04 18:45:18 johu Exp $

EAPI=4

KMNAME="kde-runtime"
KMMODULE="plasma"
DECLARATIVE_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="Script engine and package tool for plasma"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kactivities)
"
RDEPEND="${DEPEND}"

# file collisions, bug 394997
add_blocker plasma-workspace 4.4.50
