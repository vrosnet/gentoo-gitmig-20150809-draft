# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qinx/qinx-1.4.ebuild,v 1.9 2006/11/28 00:46:57 flameeyes Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A KDE style inspired by QNX Photon microGUI."
SRC_URI="http://www.usermode.org/code/${P}.tar.bz2"
HOMEPAGE="http://www.usermode.org/code.html"
LICENSE="MIT"

SLOT="0"
KEYWORDS="alpha ~amd64 ia64 -ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( kde-base/kwin >=kde-base/kdebase-3.2 )"

need-kde 3.2
