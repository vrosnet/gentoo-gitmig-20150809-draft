# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnome2.eclass,v 1.13 2002/06/12 02:40:00 spider Exp $

inherit libtool
inherit debug
# Authors:
# Bruce A. Locke <blocke@shivan.org>
# Spidler <spidler@gentoo.org>

# Gnome 2 ECLASS
ECLASS="gnome2"

G2CONF="--enable-debug=yes"
SCROLLKEEPER_UPDATE="0"

gnome2_src_configure() {
	elibtoolize 
	# doc keyword for gtk-doc
	use doc && G2CONF="${G2CONF} --enable-gtk-doc" || G2CONF="${G2CONF} --disable-gtk-doc"

	econf ${1} ${G2CONF} || die "./configure failure"

}

gnome2_src_compile() {

	gnome2_src_configure ${1}
	emake || die "compile failure"

}

gnome2_src_install() {

	# we must delay gconf schema installation due to sandbox
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"

	einstall " scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/ ${1}"

	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	# manual document installation
	if [ -n "${DOCS}" ]
	then
		dodoc ${DOCS}
	fi

	# only update scrollkeeper if this package needs it
	[ -d ${D}/var/lib/scrollkeeper ] && SCROLLKEEPER_UPDATE="1"
}

gnome2_pkg_postinst() {
	# No more SCHEMAS variable :)
	export GCONF_CONFIG_SOURCE=`/usr/bin/gconftool-2 --get-default-source`
	
	cat ${WORKDIR}/../build-info/CONTENTS | grep "obj /etc/gconf/schemas" | sed 's:obj \([^ ]*\) .*:\1:' |while read F; do
		/usr/bin/gconftool-2  --makefile-install-rule ${F}
	done
	
	# schema installation

	if [ -x /usr/bin/scrollkeeper-update ] && [ SCROLLKEEPER_UPDATE = "1" ]
	then
		echo ">>> Updating Scrollkeeper"
		scrollkeeper-update -p /var/lib/scrollkeeper
	fi
}

EXPORT_FUNCTIONS src_compile src_install pkg_postinst


