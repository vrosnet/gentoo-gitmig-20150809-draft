# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/glade-sharp/glade-sharp-1.9.3.1.ebuild,v 1.2 2005/05/16 20:13:46 slarti Exp $

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="${DEPEND} >=gnome-base/libglade-2"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
