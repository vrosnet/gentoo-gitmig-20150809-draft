# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmouth/kmouth-4.5.1.ebuild,v 1.2 2010/09/06 04:50:46 reavertm Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdeaccessibility"
KMMODULE="kmouth"

inherit kde4-meta

DESCRIPTION="KDE application that reads what you type out loud. Doesn't include a speech synthesizer."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
