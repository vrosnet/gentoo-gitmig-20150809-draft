# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr/bzr-2.2.2-r1.ebuild,v 1.3 2011/01/13 17:22:36 jer Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit bash-completion distutils elisp-common eutils versionator

MY_P=${PN}-${PV}
SERIES=$(get_version_component_range 1-2)

DESCRIPTION="Bazaar is a next generation distributed version control system."
HOMEPAGE="http://bazaar-vcs.org/"
#SRC_URI="http://bazaar-vcs.org/releases/src/${MY_P}.tar.gz"
SRC_URI="http://launchpad.net/bzr/${SERIES}/${PV}/+download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="curl doc emacs +sftp test"

# Disable until https://bugs.launchpad.net/bzr/+bug/392127 is released.
# It can be found in Bazaar 2.3
RESTRICT="test"

RDEPEND="|| ( dev-lang/python:2.7[xml] dev-lang/python:2.6[xml] dev-lang/python:2.5[xml] dev-python/celementtree )
	curl? ( dev-python/pycurl )
	sftp? ( dev-python/paramiko )"

DEPEND="emacs? ( virtual/emacs )
	test? (
		${RDEPEND}
		dev-python/medusa
		dev-python/subunit
		dev-python/testtools
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="doc/*.txt"
PYTHON_MODNAME="bzrlib"
SITEFILE="71bzr-gentoo.el"

src_prepare() {
	distutils_src_prepare

	# Fix for changed behaviour of Python 2.7, integrated into Bazaar
	# 2.3, might be a regression in Python, see
	# https://bugs.launchpad.net/bzr/+bug/612096
	# http://psf.upfronthosting.co.za/roundup/tracker/issue8194
	epatch "${FILESDIR}"/${PN}-2.2.2-python-2.7.patch
	# Don't regenerate .c files from .pyx when pyrex is found.
	epatch "${FILESDIR}/${PN}-2.2.0-no-pyrex-citon.patch"
	# Don't run lock permission tests when running as root
	# Has to be backported, tests are restricted anyway
#	epatch "${FILESDIR}/${PN}-0.90-tests-fix_root.patch"
	# Fix permission errors when run under directories with setgid set.
	epatch "${FILESDIR}/${PN}-0.90-tests-sgid.patch"
}

src_compile() {
	distutils_src_compile

	if use emacs; then
		elisp-compile contrib/emacs/bzr-mode.el || die
	fi
}

src_test() {
	# Some tests expect the usual pyc compiling behaviour.
	python_enable_pyc

	# Define tests which are known to fail below.
	local skip_tests="("
	# https://bugs.launchpad.net/bzr/+bug/456471
	skip_tests+="bzrlib.tests.blackbox.test_version.*|"
	# https://bugs.launchpad.net/bzr/+bug/392127
	skip_tests+="test_http.*"
	skip_tests+=")"
	if [[ -n ${skip_tests} ]]; then
		einfo "Skipping tests known to fail: ${skip_tests}"
	fi

	testing() {
		LC_ALL="C" "$(PYTHON -2)" bzr --no-plugins selftest ${skip_tests:+-x} ${skip_tests}
	}
	python_execute_function testing

	# Just to make sure we don't hit any errors on later stages.
	python_disable_pyc
}

src_install() {
	distutils_src_install --install-data "${EPREFIX}/usr/share"

	if use doc; then
		docinto developers
		dodoc doc/developers/* || die
		for doc in mini-tutorial tutorials user-{guide,reference}; do
			docinto $doc
			dodoc doc/en/$doc/* || die
		done
	fi

	if use emacs; then
		elisp-install ${PN} contrib/emacs/*.el* || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

		# don't add automatically to the load-path, so the sitefile
		# can do a conditional loading
		touch "${ED}${SITELISP}/${PN}/.nosearch"
	fi

	dobashcompletion contrib/bash/bzr
}

pkg_postinst() {
	distutils_pkg_postinst
	bash-completion_pkg_postinst

	if use emacs; then
		elisp-site-regen
		elog "If you are using a GNU Emacs version greater than 22.1, bzr support"
		elog "is already included.  This ebuild does not automatically activate bzr support"
		elog "in versions below, but prepares it in a way you can load it from your ~/.emacs"
		elog "file by adding"
		elog "       (load \"bzr-mode\")"
	fi
}

pkg_postrm() {
	distutils_pkg_postrm
	use emacs && elisp-site-regen
}
