# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/quickcheck/quickcheck-1.0.ebuild,v 1.7 2007/03/27 13:32:07 josejx Exp $

inherit ghc-package

DESCRIPTION="An automatic, specification based testing utility for Haskell programs"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 hppa ~ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="=virtual/ghc-6.4*"

pkg_setup () {
	ghc-package_pkg_setup
	einfo "This library is already provided by ghc. This ebuild does nothing."
}

src_install () {
	dodir "$(ghc-libdir)"
	touch "${D}/$(ghc-libdir)/.${P}.ghc-updater"
}
