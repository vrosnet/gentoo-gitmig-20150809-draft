# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-4.0.1.ebuild,v 1.1 2008/02/07 00:10:46 philantrop Exp $

EAPI="1"

KMNAME=kdesdk
inherit kde4-meta

DESCRIPTION="KDE: Umbrello UML Modeller"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

COMMONDEPEND="dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${DEPEND} ${COMMONDEPEND}"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"
