# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cabal/cabal-1.14.0.ebuild,v 1.1 2012/03/04 02:33:04 gienah Exp $

# ebuild generated by hackport 0.2.12

EAPI="4"

CABAL_FEATURES="bootstrap lib profile"
inherit haskell-cabal eutils versionator

MY_PN="Cabal"
MY_PV=$(get_version_component_range '1-3')
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://www.haskell.org/cabal/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc"

RESTRICT="test" # avoid circular deps

DEPEND=">=dev-lang/ghc-6.10.1"
RDEPEND="${DEPEND}
		dev-util/pkgconfig"
# cabal uses dev-util/pkgconfig using runtime to resolve C dependencies, so
# repoman's RDEPEND.suspect QA does not apply here

S="${WORKDIR}/${MY_PN}-${MY_PV}"

CABAL_CORE_LIB_GHC_PV="7.4.0.20111219 7.4.0.20120126 7.4.1"

src_configure() {
	if ! cabal-is-dummy-lib; then
		einfo "Bootstrapping Cabal..."
		$(ghc-getghc) -i -i. -i"${WORKDIR}/${FP_P}" -cpp --make Setup.hs \
			-o setup || die "compiling Setup.hs failed"
		cabal-configure
	fi
}

src_compile() {
	if ! cabal-is-dummy-lib; then
		cabal-build
	fi
}
