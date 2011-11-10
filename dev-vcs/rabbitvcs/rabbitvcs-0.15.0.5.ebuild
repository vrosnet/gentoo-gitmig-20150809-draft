# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/rabbitvcs/rabbitvcs-0.15.0.5.ebuild,v 1.2 2011/11/10 16:05:20 mr_bones_ Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit gnome2-utils distutils

DESCRIPTION="Integrated version control support for your desktop"
HOMEPAGE="http://rabbitvcs.org"
SRC_URI="http://rabbitvcs.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cli diff gedit git nautilus spell thunar"

RDEPEND="dev-python/configobj
	dev-python/pygobject:2
	dev-python/pygtk
	dev-python/pysvn
	dev-python/simplejson
	diff? ( dev-util/meld )
	gedit? ( app-editors/gedit )
	git? ( dev-python/dulwich )
	nautilus? ( >=dev-python/nautilus-python-0.7.0
		dev-python/dbus-python
		dev-python/gnome-vfs-python )
	spell? ( dev-python/gtkspell-python )
	thunar? ( dev-python/thunarx-python
		dev-python/dbus-python )"

src_prepare() {
	python_convert_shebangs -r 2 .

	distutils_src_prepare

	# we should not do gtk-update-icon-cache from setup script
	# we prefer portage for that
	sed -e 's/"install"/"fakeinstall"/' -i "${S}/setup.py" || die
}

src_install() {
	distutils_src_install

	if use cli ; then
		dobin clients/cli/${PN}
	fi
	if use gedit ; then
		insinto /usr/$(get_libdir)/gedit-2/plugins
		doins clients/gedit/${PN}-plugin.py
		doins clients/gedit/${PN}.gedit-plugin
	fi
	if use nautilus ; then
		insinto /usr/$(get_libdir)/nautilus/extensions-2.0/python
		doins clients/nautilus/RabbitVCS.py
		insinto /usr/$(get_libdir)/nautilus/extensions-3.0/python
		doins clients/nautilus-3.0/RabbitVCS.py
	fi
	if use thunar ; then
		insinto "/usr/$(get_libdir)/thunarx-2/python"
		doins clients/thunar/RabbitVCS.py
		insinto "/usr/$(get_libdir)/thunarx-1/python"
		doins clients/thunar/RabbitVCS.py
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_icon_cache_update

	elog "You should restart file manager to changes take effect:"
	use nautilus && elog "\$ nautilus -q"
	use thunar && elog "\$ thunar -q && thunar &"
	elog ""
	elog "Also you should really look at known issues page:"
	elog "http://wiki.rabbitvcs.org/wiki/support/known-issues"
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_icon_cache_update
}
