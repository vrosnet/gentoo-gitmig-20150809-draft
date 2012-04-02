# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bootchart2/bootchart2-0.14.2.ebuild,v 1.1 2012/04/02 07:19:16 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABI="2.7-pypy-*"

inherit linux-info python systemd toolchain-funcs

DESCRIPTION="Performance analysis and visualization of the system boot process"
HOMEPAGE="https://github.com/mmeeks/bootchart/"
SRC_URI="mirror://github/mmeeks/bootchart/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="svg"

RDEPEND="
	!app-benchmarks/bootchart
	dev-python/pycairo[svg=]"
DEPEND="${RDEPEND}
"

CONFIG_CHECK="~PROC_EVENTS ~TASKSTATS ~TASK_DELAY_ACCT ~TMPFS"

src_prepare() {
	tc-export CC
	sed \
		-e "/^install/s:py-install-compile::g" \
		-e "/^VER/s:0.14.1:0.14.2:g" \
		-e "/^SYSTEMD_UNIT_DIR/s:=.*:= $(systemd_get_unitdir):g" \
		-i Makefile || die
}

src_install() {
	export NO_PYTHON_COMPILE=0
	export DOCDIR=/usr/share/doc/${PF}
	default

	# Note: LIBDIR is hardcoded as /lib in collector/common.h, so we shouldn't
	# just change it. Since no libraries are installed, /lib is fine.
	keepdir /lib/bootchart/tmpfs

	installation() {
		emake \
			DESTDIR="${D}" \
			PY_SITEDIR=$(python_get_sitedir) \
			py-install-compile
	}
	python_execute_function installation
}

src_test() {
	testing() {
		emake test
	}
	python_execute_function testing
}

pkg_postinst() {
	elog "Please review /usr/share/doc/${PF}/README"
	elog "for further usage informations."
}
