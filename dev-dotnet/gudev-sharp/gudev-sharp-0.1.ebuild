# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gudev-sharp/gudev-sharp-0.1.ebuild,v 1.4 2011/06/07 08:09:43 pacho Exp $

EAPI=2
inherit mono

DESCRIPTION="GUDEV API C# binding"
HOMEPAGE="http://launchpad.net/gudev-sharp"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${PN}-1.0-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-dotnet/gtk-sharp-1.9
	>=dev-dotnet/gtk-sharp-gapi-1.9
	|| ( >=sys-fs/udev-146[extras] >=sys-fs/udev-171[gudev] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}-1.0-${PV}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS
}
