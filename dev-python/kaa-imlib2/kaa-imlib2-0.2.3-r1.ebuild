# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-imlib2/kaa-imlib2-0.2.3-r1.ebuild,v 1.4 2009/12/26 20:13:54 pacho Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Imlib2 wrapper for Python."
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE=""

DEPEND=">=dev-python/kaa-base-0.3.0
	dev-libs/libxml2[python]
	media-libs/imlib2"
RDEPEND="${DEPEND}"

RESTRICT_PYTHON_ABIS="2.4 3*"

PYTHON_MODNAME="kaa"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/kaa-imlib2-remove-png-dep.patch"
}
