      MESSIER - Simulates the formation of globular star clusters
      ===========================================================
           (c) 1998 Mauro J. Cavalcanti. All rights reserved.

MESSIER is a Microsoft Windows '95 32-bit application which simulates
the formation of globular star clusters. Vary the number of stars and
watch how clustering patterns remarkably similar to true astronomical
objects evolve over time.

This program has been developed using Borland Delphi 2.0/3.0 for Windows
'95 and Windows NT 4.0 and is based on a BASIC version that appeared in
the "Astronomical Computing" section of the _Sky & Telescope_ Magazine,
April 1986, p. 398.

The MESSIER distribution package includes the following files:

        MAIN.PAS    - Main unit source code
        MAIN.DFM    - Main unit form file
        ABOUT.PAS   - About unit source code
        ABOUT.DFM   - About unit form file
        MESSIER.RES - MESSIER 32-bit resource file
        MESSIER.DOF - MESSIER Delphi 2.0/3.0 options file
        MESSIER.DPR - MESSIER main program
        MESSIER.EXE - MESSIER 32-bit executable program
        MESSIER.ICO - MESSIER icon file (32 x 32, 16 colors)
        README.TXT  - This file!

Unzip the distribution file MESSIER.ZIP, using an output directory of
your choice (e.g. c:\messier). The above files will be created.
MESSIER.ZIP may then be deleted to save space.

To start the program, double-click the file MESSIER.EXE From Windows
Explorer. Choose the "Run" option from the main menu to execute a
simulation.

This program may be freely copied and modified, as long as the above
copyright notice is not removed and modifications are documented. No
price or fee may be charged for it.

The latest versions will be made available directly over the Internet
from my Web page at http://meusite.osite.com.br/maurobio/index.html

If anyone makes any significant alterations or has any bright ideas to
enhance this program then please forward them to me so I can keep one up
to date copy. Comments may be sent by e-mail to the address:
maurobio@geocities.com

Disclaimer: this program is provided as is, without warranty of any
kind. Use it at your own risk.

MESSIER Revision History
========================

Version 1.00, 05/05/98 - Initial release.
Version 1.01, 11/05/98 - Added color cycling to plot and number of stars
                         plotted in cluster to the main window caption.
                         More comments included to the program code.
Version 1.02, 09/06/98 - Fixed a bug that caused the program's description
                         in the "About" dialog box to be partly chopped off
                         at different screen resolutions.
Version 1.03, 28/06/98 - Added support to the orange color when plotting
                         stars, with a call to the RGB Windows API function.
Version 1.04, 18/07/98 - Added a call to the ProcessMessages method of the
                         application's main window to yield for other
                         events when plotting a large number of stars.
                         Added a call to the globular cluster plotting
                         procedure to the OnPaint and the OnResize
                         events. Beautified.
Version 1.05, 16/08/98 - Fixed a bug that prevented the clearing of the main
                         window's display area when no stars was selected for
                         plotting. Recompiled in Delphi 3.0.
Version 1.06, 02/06/23 - Recompiled in Delphi 7.0.
						
