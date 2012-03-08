# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/language-c/language-c-0.3.2.1.ebuild,v 1.4 2012/03/08 09:35:45 phajdan.jr Exp $

# ebuild generated by hackport 0.2.9

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Analysis and generation of C code"
HOMEPAGE="http://www.sivity.net/projects/language.c/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1"
DEPEND="${RDEPEND}
		dev-haskell/alex
		>=dev-haskell/cabal-1.2.3
		dev-haskell/happy"
