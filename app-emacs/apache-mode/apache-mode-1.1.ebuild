# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/apache-mode/apache-mode-1.1.ebuild,v 1.6 2005/10/24 13:24:26 josejx Exp $

inherit elisp

IUSE=""

DESCRIPTION="Major mode for editing Apache configuration files"
HOMEPAGE="http://www.keelhaul.demon.co.uk/linux/#apachemode"
SRC_URI="mirror://gentoo/${P}.el.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

DEPEND="virtual/emacs"

SITEFILE=50apache-mode-gentoo.el
S="${WORKDIR}"

src_compile() {
	mv ${P}.el apache-mode.el
	elisp-compile *.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/apache-mode.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
