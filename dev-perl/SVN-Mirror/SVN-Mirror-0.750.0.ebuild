# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVN-Mirror/SVN-Mirror-0.750.0.ebuild,v 1.1 2011/08/29 09:33:08 tove Exp $

EAPI=4
MODULE_AUTHOR=CLKAO
MODULE_VERSION=0.75
inherit perl-module eutils

DESCRIPTION="SVN::Mirror - Mirror remote repositories to local subversion repository"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-vcs/subversion-1.1.3[perl]
	>=dev-perl/URI-1.34
	>=dev-perl/TermReadKey-2.21
	>=dev-perl/SVN-Simple-0.26
	dev-perl/Data-UUID
	dev-perl/Class-Accessor
	dev-perl/TimeDate
	dev-perl/File-chdir"
DEPEND="${RDEPEND}"

SRC_TEST=do
