# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/racc/racc-1.4.3.ebuild,v 1.2 2003/02/13 11:40:54 vapier Exp $

S=${WORKDIR}/${P}-all
DESCRIPTION="LALR parser generator for Ruby"
SRC_URI="http://www.loveruby.net/archive/racc/${P}-all.tar.gz"
HOMEPAGE="http://www1.u-netsurf.ne.jp/~brew/mine/en/index.html"
LICENSE="LGPL"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.6.1
        >=dev-ruby/amstd-1.9.5"

src_compile() {
	ruby setup.rb config --without=amstd || die
	ruby setup.rb setup || die
}

src_install () {
	# It appears that this reconfig doesn't hurt anything.
	# The --prefix and --rb-dir args don't work on the install line.
	RB_DIR=`ruby -e 'require "rbconfig"; puts Config::CONFIG["sitelibdir"]'`
	ruby setup.rb config \
		--prefix=${D}/usr \
		--rb-dir=${D}${RB_DIR} || die
	ruby setup.rb install || die
}
