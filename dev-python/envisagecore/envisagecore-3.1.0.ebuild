# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/envisagecore/envisagecore-3.1.0.ebuild,v 1.1 2009/03/27 10:39:41 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="EnvisageCore"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite extensible application framework"
HOMEPAGE="http://code.enthought.com/projects/envisage/"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/apptools-3.2
	>=dev-python/traits-3.1
	>=dev-python/enthoughtbase-3.0.2"

DEPEND="dev-python/setuptools
	doc? ( dev-python/setupdocs )
	test? ( >=dev-python/nose-0.10.3
			>=dev-python/apptools-3.2
			>=dev-python/enthoughtbase-3.0.2 )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_compile() {
	distutils_src_compile
	if use doc; then
		"${python}" setup.py build_docs --formats=html,pdf \
			|| die "doc building failed"
	fi
}

src_test() {
	PYTHONPATH=build/lib ${python} setup.py test || die "tests failed"
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/docs/html || die
		doins build/docs/latex/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
