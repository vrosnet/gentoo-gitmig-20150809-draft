/* This file hold the various bits of the config file for XFree86 4.0.0+ */

static char *MainChunk_text =
"# File generated by Xautoconfig4.\n"
"Section \"ServerLayout\"\n"
"	Identifier	\"XFree86 Configured\"\n"
"	Screen		0  \"Screen0\" 0 0\n"
"	InputDevice	\"Mouse0\" \"CorePointer\"\n"
"	InputDevice	\"Keyboard0\" \"CoreKeyboard\"\n"
"EndSection\n"
"\n"
"Section \"Files\"\n"
"# The location of the RGB database.  Note, this is the name of the\n"
"# file minus the extension (like \".txt\" or \".db\").  There is normally\n"
"# no need to change the default.\n"
"\n"
"	RgbPath	\"/usr/X11R6/lib/X11/rgb\"\n"
"\n"
"# Multiple FontPath entries are allowed (which are concatenated together),\n"
"# as well as specifying multiple comma-separated entries in one FontPath\n"
"# command (or a combination of both methods)\n"
"\n"
"	FontPath	\"unix/:7100\"\n"
"	FontPath	\"unix/:-1\"\n"
"	# If X can't find it's default font, try uncommenting these:\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/local/\"\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/misc/\"\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/truetype/\"\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/75dpi/:unscaled\"\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/100dpi/:unscaled\"\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/Type1/\"\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/CID/\"\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/Speedo/\"\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/75dpi/\"\n"
"	FontPath	\"/usr/X11R6/lib/X11/fonts/100dpi/\"\n"
"\n"
"# ModulePath can be used to set a search path for the X server modules.\n"
"# The default path is shown here.\n"
"\n"
"#	ModulePath	\"/usr/X11R6/lib/modules\"\n"
"\n"
"EndSection\n"
"\n"
"Section \"Module\"\n"
"	Load	\"GLcore\"\n"
"	Load	\"dbe\"\n"
"	Load	\"extmod\"\n"
"	Load	\"glx\"\n"
"	Load	\"pex5\"\n"
"	Load	\"record\"\n"
"	Load	\"xie\"\n"
"	Load	\"bitmap\"\n"
"	Load	\"type1\"\n"
"	Load	\"speedo\"\n"
"	Load	\"freetype\"\n"
"	# Uncomment for Video4Linux support\n"
"	#Load	\"v4l\"\n"
"EndSection\n"
"\n"
"Section \"InputDevice\"\n"
"	Identifier	\"Keyboard0\"\n"
"	Driver		\"keyboard\"\n";

static char *keyboard_adb =
"	Option		\"CustomKeycodes\"\n"
"	Option		\"XkbModel\"	\"macintosh\"\n"
"	Option		\"XkbRules\"	\"xfree\"\n"
"	Option		\"XkbLayout\"	\"us\"\n";

static char *keyboard_adbcom =
"# Uncomment this if your keyboard no longer works in X and you belive you are\n"
"# using the depreciated adb keycodes\n"
"	#Option		\"CustomKeycodes\"\n"
"	#Option		\"XkbModel\"	\"macintosh\"\n"
"	Option		\"XkbRules\"	\"xfree\"\n"
"	#Option		\"XkbLayout\"	\"us\"\n";

/* Uncomment/fix this for APUS support
static char *keyboardsection_powerpc_amiga =
"   XkbKeycodes	\"amiga\"\n"
"   XkbTypes	\"default\"\n"
"   XkbCompat	\"default\"\n"
"   XkbSymbols	\"amiga\"\n" 
"   XkbGeometry	\"amiga\"\n"
"   XkbRules	\"xfree86\"\n"
"   XkbModel	\"pc101\"\n"
"EndSection\n\n"
"";
*/

static char *mouse_section = 
"Section \"InputDevice\"\n"
"	Identifier	\"Mouse0\"\n"
"	Driver   	\"mouse\"\n"
"	Option   	\"ZAxisMapping\"	\"4 5\"\n"
"	Option   	\"Protocol\"	\"";

static char *monitor_section =
"EndSection\n"
"\n"
"Section \"Monitor\"\n"
"	Identifier	\"Monitor0\"\n"
"	UseModes	\"Modes0\"\n"
"	ModelName	\"Monitor Model\"\n"
"	Option		\"DPMS\"\n";

static char *modes_section =
"EndSection\n\n"
"Section \"Modes\"\n"
"	Identifier	\"Modes0\"\n"
"\n"
"	# Apple iMac modes\n"
"	Modeline \"1024x768\"   78.525 1024 1049 1145 1312   768  769  772  800 +hsync +vsync\n"
"	Modeline \"800x600\"    62.357  800  821  901 1040   600  601  604  632 +hsync +vsync\n"
"	Modeline \"640x480\"    49.886  640  661  725  832   480  481  484  514 +hsync +vsync\n"
"	# Apple monitors tend to do 832x624\n"
"	Modeline \"832x624\"    57      832  876  940 1152   624  625  628  667 -hsync -vsync\n"
"	# Apple PowerBook G3\n"
"	Modeline \"800x600\"    100     800  816  824  840   600  616  624  640 -hsync -vsync\n"
"	# Generated\n";

static char *device_start =
"\n"
"EndSection\n"
"Section \"Device\"\n"
"	Identifier	\"Card0\"\n";

static char *driver_on_opts =
"	### Available Driver options are:-\n"
"	#Option	\"SWcursor\"\n"
"	Option	\"HWcursor\"\n"
"	#Option	\"PciRetry\"\n"
"	#Option	\"NoAccel\"\n"
"	#Option	\"ShadowFB\"	\"true\"\n"
"	Option	\"UseFBDev\"\n";



static char *driver_off_opts =
"	### Available Driver options are:-\n"
"	#Option	\"SWcursor\"\n"
"	#Option	\"HWcursor\"\n"
"	#Option	\"PciRetry\"\n"
"	#Option	\"NoAccel\"\n"
"	#Option	\"ShadowFB\"	\"true\"\n"
"	#Option	\"UseFBDev\"\n";

static char *screen_section =
"EndSection\n"
"\n"
"Section \"Screen\"\n"
"	Identifier	\"Screen0\"\n"
"	Device		\"Card0\"\n"
"	Monitor		\"Monitor0\"\n"
"	DefaultDepth	";
