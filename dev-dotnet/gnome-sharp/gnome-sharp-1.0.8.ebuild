# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnome-sharp/gnome-sharp-1.0.8.ebuild,v 1.5 2005/05/16 20:13:46 slarti Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~amd64 ppc x86"
IUSE=""

# FIXME
DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		>=gnome-base/libgnomecanvas-2.2
		>=gnome-base/libgnomeui-2.2
		>=gnome-base/libgnomeprintui-2.2
		>=x11-libs/gtk+-2.2
		=dev-dotnet/art-sharp-${PV}*"

GTK_SHARP_COMPONENT_BUILD_DEPS="art"
