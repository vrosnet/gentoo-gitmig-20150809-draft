# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kamikaze/kamikaze-0.1.0.ebuild,v 1.8 2005/08/28 22:33:53 mr_bones_ Exp $

inherit kde

DESCRIPTION="A bomberman like game for KDE"
HOMEPAGE="http://kamikaze.coolprojects.org/"
SRC_URI="http://kamikaze.coolprojects.org/download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc x86"
SLOT="0"
IUSE=""

need-kde 3
