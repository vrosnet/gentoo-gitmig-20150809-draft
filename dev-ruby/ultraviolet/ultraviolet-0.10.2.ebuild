# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ultraviolet/ultraviolet-0.10.2.ebuild,v 1.1 2009/06/28 08:14:33 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A syntax highlighting engine based on Textpow"
HOMEPAGE="http://ultraviolet.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5
	>=dev-ruby/textpow-0.10.0"
