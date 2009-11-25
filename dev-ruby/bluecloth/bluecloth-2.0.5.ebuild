# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bluecloth/bluecloth-2.0.5.ebuild,v 1.4 2009/11/25 09:46:24 maekke Exp $

inherit ruby gems

DESCRIPTION="A Ruby implementation of Markdown"
HOMEPAGE="http://www.deveiate.org/projects/BlueCloth"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ~ppc64 x86"
IUSE=""

USE_RUBY="ruby18 ruby19"
DEPEND=">=dev-lang/ruby-1.8"
RDEPEND="${DEPEND}"
