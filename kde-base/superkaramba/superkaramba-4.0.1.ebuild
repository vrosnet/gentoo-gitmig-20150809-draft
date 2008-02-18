# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-4.0.1.ebuild,v 1.3 2008/02/18 17:06:03 ingmar Exp $

EAPI="1"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook python"

COMMONDEPEND="kde-base/qimageblitz
	|| ( >=kde-base/plasma-$PV:$SLOT
		>=kde-base/kdebase-${PV}:${SLOT} )
	python? ( dev-lang/python )"
DEPEND="${DEPEND} ${COMMONDEPEND}"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

PATCHES="${FILESDIR}/${P}-as-needed.patch"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with python PythonLibs)"

	kde4-meta_src_compile
}
