# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sancho/sancho-2.4.ebuild,v 1.4 2009/10/22 20:57:59 klausman Exp $

EAPI="2"

NEED_PYTHON="2.4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P=${P/s/S}
DESCRIPTION="Sancho is a unit testing framework"
HOMEPAGE="http://www.mems-exchange.org/software/sancho/"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${MY_P}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt"

src_test() {
	cd test
	testing() {
		local test test_failure test_failure_count=0
		for test in *.py; do
			test_failure="0"
			ebegin "Testing ${test}"
			PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" "${test}" > "${test}.output"
			grep -Eqv "^${test}: .*:$" "${test}.output" && test_failure="1"
			eend "${test_failure}"
			if [[ "${test_failure}" == "1" ]]; then
				((test_failure_count++))
				eerror "Failure output for ${test}"
				cat "${test}.output"
			fi
		done
		if [[ "${test_failure_count}" -gt "0" ]]; then
			die "${test_failure_count} tests failed with Python ${PYTHON_ABI}"
		fi
	}
	python_execute_function testing
}
