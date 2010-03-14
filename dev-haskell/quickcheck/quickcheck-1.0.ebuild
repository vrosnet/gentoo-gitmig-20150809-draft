# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/quickcheck/quickcheck-1.0.ebuild,v 1.15 2010/03/14 18:42:10 kolmodin Exp $

inherit ghc-package

DESCRIPTION="An automatic, specification based testing utility for Haskell programs"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI=""
LICENSE="BSD"
SLOT="1"

KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="=dev-lang/ghc-6.4*"

pkg_setup () {
	ghc-package_pkg_setup
	elog "This library is already provided by ghc. This ebuild does nothing."
}

src_install () {
	dodir "$(ghc-libdir)"
	touch "${D}/$(ghc-libdir)/.${P}.ghc-updater"
}
