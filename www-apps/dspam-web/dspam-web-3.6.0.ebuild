# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dspam-web/dspam-web-3.6.0.ebuild,v 1.1 2005/11/05 15:53:55 st_lim Exp $

inherit webapp eutils

MY_PN=${PN/-web/}
MY_P=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Web based administration and user controls for dspam"
SRC_URI="http://dspam.nuclearelephant.com/sources/${MY_P}.tar.gz
		http://dspam.nuclearelephant.com/sources/extras/dspam_sa_trainer.tar.gz"
HOMEPAGE="http://dspam.nuclearelephant.com/"
LICENSE="GPL-2"

IUSE="clamav debug large-domain logrotate mysql neural oci8 postgres sqlite virtual-users"
DEPEND=">=mail-filter/dspam-${PV}
		clamav? ( >=app-antivirus/clamav-0.86 )
		mysql? ( >=dev-db/mysql-3.23 )
		sqlite? ( dev-db/sqlite )
		postgres? ( >=dev-db/postgresql-7.4.3 )
		>=sys-libs/db-4.0
		>=net-www/apache-1.3
		>=dev-lang/perl-5.8.2
		>=dev-perl/GD-2.0
		dev-perl/GD-Graph3d
		dev-perl/GDGraph
		dev-perl/GDTextUtil"
KEYWORDS="~x86 ~ppc ~amd64"

# some FHS-like structure
HOMEDIR="/var/spool/dspam"
CONFDIR="/etc/mail/dspam"
LOGDIR="/var/log/dspam"

src_compile() {
	local myconf

	myconf="${myconf} --enable-long-username"
	myconf="${myconf} --with-delivery-agent=/usr/bin/procmail"
	use large-domain && myconf="${myconf} --enable-large-scale" ||\
	    myconf="${myconf} --enable-domain-scale"

	myconf="${myconf} --with-dspam-home=${HOMEDIR}"
	myconf="${myconf} --sysconfdir=${CONFDIR}"
	use virtual-users || myconf="${myconf} --enable-homedir"
	use clamav || myconf="${myconf} --enable-clamav"

	# enables support for debugging (touch /etc/dspam/.debug to turn on)
	# optional: even MORE debugging output, use with extreme caution!
	use debug && myconf="${myconf} --enable-debug --enable-verbose-debug"

	# select storage driver
	if use sqlite ; then
		myconf="${myconf} --with-storage-driver=sqlite_drv"
		myconf="${myconf} --enable-virtual-users"
	elif use mysql; then
		myconf="${myconf} --with-storage-driver=mysql_drv"
		myconf="${myconf} --with-mysql-includes=/usr/include/mysql"
		myconf="${myconf} --with-mysql-libraries=/usr/lib/mysql"
		myconf="${myconf} --enable-preferences-extension"

		if has_version ">sys-kernel/linux-headers-2.6"; then
			myconf="${myconf} --enable-daemon"
		fi

		use virtual-users && myconf="${myconf} --enable-virtual-users"
		# an experimental feature available with MySQL and PgSQL backend
		use neural && myconf="${myconf} --enable-neural-networking"
	elif use postgres ; then
		myconf="${myconf} --with-storage-driver=pgsql_drv"
		myconf="${myconf} --with-pgsql-includes=/usr/include/postgresql"
		myconf="${myconf} --with-pgsql-libraries=/usr/lib/postgresql"
		myconf="${myconf} --enable-preferences-extension"

		if has_version ">sys-kernel/linux-headers-2.6"; then
			myconf="${myconf} --enable-daemon"
		fi

		use virtual-users && myconf="${myconf} --enable-virtual-users"
		# an experimental feature available with MySQL and PgSQL backend
		use neural && myconf="${myconf} --enable-neural-networking"
	elif use oci8 ; then
		myconf="${myconf} --with-storage-driver=ora_drv"
		myconf="${myconf} --with-oracle-home=${ORACLE_HOME}"
		myconf="${myconf} --enable-virtual-users"

		# I am in no way a Oracle specialist. If someone knows
		# how to query the version of Oracle, then let me know.
		if (expr ${ORACLE_HOME/*\/} : 10 1>/dev/null 2>&1); then
			myconf="${myconf} --with-oracle-version=10"
		fi
	else
		myconf="${myconf} --with-storage-driver=libdb4_drv"
	fi

	econf ${myconf} || die
	cd ${S}/webui
	make
}

src_install () {
	cd ${S}/webui
	webapp_src_preinst

	sed -e 's,/var/dspam,/etc/mail/dspam,' \
		-e 's,/usr/local,/usr,' \
		-i ${S}/webui/cgi-bin/admin.cgi
	sed -e 's,/var/dspam,/etc/mail/dspam,' \
		-e 's,/usr/local,/usr,' \
		-i ${S}/webui/cgi-bin/admingraph.cgi
	sed -e 's,/var/dspam,/etc/mail/dspam,' \
		-e 's,/usr/local,/usr,' \
		-i ${S}/webui/cgi-bin/dspam.cgi
	sed -e 's,/var/dspam,/etc/mail/dspam,' \
		-e 's,/usr/local,/usr,' \
		-i ${S}/webui/cgi-bin/graph.cgi

	insinto ${MY_HTDOCSDIR}
	insopts -m644 -o apache -g apache
	doins ${S}/webui/htdocs/base.css
	doins ${S}/webui/htdocs/dspam-logo-small.gif
	doins ${S}/webui/cgi-bin/rgb.txt
	doins ${S}/webui/cgi-bin/default.prefs
	doins ${S}/webui/cgi-bin/admins
	doins ${S}/webui/cgi-bin/configure.pl

	newins ${FILESDIR}/htaccess .htaccess
	newins ${FILESDIR}/htpasswd .htpasswd

	insopts -m755 -o apache -g apache
	doins ${S}/webui/cgi-bin/*.cgi

	for CGI_SCRIPT in admin.cgi admingraph.cgi dspam.cgi graph.cgi; do
		webapp_runbycgibin perl ${MY_HTDOCSDIR}/${CGI_SCRIPT}
	done

	dodir ${MY_HTDOCSDIR}/templates

	insinto ${MY_HTDOCSDIR}/templates
	doins ${S}/webui/cgi-bin/templates/*.html

	#All files must be owned by server
	cd ${D}${MY_HTDOCSDIR}
	for x in `find . -type f -print` ; do
		webapp_serverowned ${MY_HTDOCSDIR}/$x
	done

	webapp_src_install
}

pkg_config () {
	# add apache to the dspam group so the CGIs can access the data

	local groups
	groups=`groups apache`
	groups=`echo ${groups} | sed -e 's/ /,/g'`
	usermod -G "${groups},dspam" apache
}

pkg_postinst () {
	einfo "The CGIs need to be executed as group dspam in order to write"
	einfo "to the dspam data directory. You will need to configure apache"
	einfo "manually to do this. Another option is to add the user apache"
	einfo "to the dspam group. You can do this automatically by running:"
	echo
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	echo
	einfo "This app requires basic auth in order to operate properly."
	einfo "You will need to add dspam users to the .htpasswd file or"
	einfo "configure a different authentication mechanism for the user"
	einfo "accounts."
}
