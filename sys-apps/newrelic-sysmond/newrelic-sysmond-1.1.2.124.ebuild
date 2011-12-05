# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/newrelic-sysmond/newrelic-sysmond-1.1.2.124.ebuild,v 1.1 2011/12/05 22:13:35 trapni Exp $

EAPI=4

inherit eutils

DESCRIPTION="NewRelic System Monitor"
HOMEPAGE="http://www.newrelic.com/"
SRC_URI="http://download.newrelic.com/server_monitor/release/${P}-linux.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="strip"
#DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-linux"

pkg_setup() {
	enewgroup newrelic
	enewuser newrelic -1 -1 -1 newrelic
}

src_install() {
	if [[ "${ARCH}" == "amd64" ]]; then
		NR_ARCH="x64"
	elif [[ "${ARCH}" == "x86" ]]; then
		NR_ARCH="x86"
	else
		die "Unsupported architecture (${ARCH})"
	fi

	dosbin "scripts/nrsysmond-config"
	newsbin "daemon/nrsysmond.${NR_ARCH}" "nrsysmond"
	newinitd "${FILESDIR}/newrelic-sysmond.rc" "newrelic-sysmond"

	keepdir "/etc/newrelic"
	insinto "/etc/newrelic"
	doins nrsysmond.cfg

	keepdir "/var/run/newrelic"
	fowners newrelic.newrelic "/var/run/newrelic"
	fperms 0775 "/var/run/newrelic"

	keepdir "/var/log/newrelic"
	fowners newrelic.newrelic "/var/log/newrelic"
	fperms 0775 "/var/log/newrelic"

	dodoc INSTALL.txt LICENSE.txt
}

pkg_postinst() {
	elog "remember to set your license key via:"
	elog
	elog "    newrelic-config --set license_key=\$YOUR_KEY"
}
