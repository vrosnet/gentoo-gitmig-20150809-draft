# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hpc/hpc-0.5.0.5.ebuild,v 1.1 2010/06/13 22:14:27 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Code Coverage Library for Haskell"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/hpc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.8
		>=dev-haskell/cabal-1.6"

CABAL_CORE_LIB_GHC_PV="6.12.3"
