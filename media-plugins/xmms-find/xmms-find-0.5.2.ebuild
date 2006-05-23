# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-find/xmms-find-0.5.2.ebuild,v 1.5 2006/05/23 19:43:00 corsair Exp $

IUSE=""

inherit eutils

MY_P=${PN/-/}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An xmms plugin to allow regexp searching, enqueuing and playing of files"
HOMEPAGE="http://xmmsfind.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmmsfind/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"

DEPEND=">=media-sound/xmms-1.2.8"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	plugin_install_dir="${D}$(xmms-config --general-plugin-dir)"
	make \
		PLUGIN_INSTALL_DIR=${plugin_install_dir} \
		REMOTE_INSTALL_DIR=${D}/usr/bin install || die "install failed"

	dodoc BUGS README TODO VERSION
}
