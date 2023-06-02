      MESSIER - Simulates the formation of globular star clusters
      ===========================================================
        (c) 1998-2019 Mauro J. Cavalcanti. All rights reserved.

MESSIER is a Microsoft Windows 32-bit application which simulates
the formation of globular star clusters. Vary the number of stars and
watch how clustering patterns remarkably similar to true astronomical
objects evolve over time.

This program has been originally developed using Borland Delphi 2.0/3.0 
for Windows '95 and later ported to Free Pascal 3.0/Lazarus 2.0 for 
Windows 10; it is based on a BASIC version that appeared in the 
"Astronomical Computing" section of the _Sky & Telescope_ Magazine, 
April 1986, p. 398.

The MESSIER distribution package includes the following files:

        MAIN.PAS    - Main unit source code
        MAIN.LFM    - Main unit form file
        ABOUT.PAS   - About unit source code
        ABOUT.LFM   - About unit form file
        MESSIER.RES - MESSIER 32-bit resource file
        MESSIER.LPR - MESSIER main program
        MESSIER.EXE - MESSIER 32-bit executable program
        MESSIER.ICO - MESSIER icon file (32 x 32, 16 colors)
		GPL.TXT	    - Text of GNU General Public License 
        README.TXT  - This file!

Unzip the distribution file MESSIER.ZIP, using an output directory of
your choice (e.g. c:\messier). The above files will be created.
MESSIER.ZIP may then be deleted to save space.

To start the program, double-click the file MESSIER.EXE From Windows
Explorer. Choose the "Run" option from the main menu to execute a
simulation.

This program is free software: you can redistribute it and/or modify   
it under the terms of the GNU General Public License as published by   
the Free Software Foundation, either version 3 of the License, or      
(at your option) any later version.                                    
                                                                       
This program is distributed in the hope that it will be useful,        
but WITHOUT ANY WARRANTY; without even the implied warranty of         
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          
GNU General Public License for more details.                           
                                                                       
You should have received a copy of the GNU General Public License      
along with this program. If not, see <http://www.gnu.org/licenses/>.   

The latest versions will be made available directly over the Internet
from my Web page at <http://sites.google.com/site/maurobio>.

If anyone makes any significant alterations or has any bright ideas to
enhance this program then please forward them to me so I can keep one up
to date copy. Comments may be sent by e-mail to the address:
<maurobio@gmail.com>

MESSIER Revision History
========================

Version 1.00, 05/05/1998 - Initial release.
Version 1.01, 11/05/1998 - Added color cycling to plot and number of stars
                           plotted in cluster to the main window caption.
                           More comments included to the program code.
Version 1.02, 09/06/1998 - Fixed a bug that caused the program's description
                           in the "About" dialog box to be partly chopped off
                           at different screen resolutions.
Version 1.03, 28/06/1998 - Added support to the orange color when plotting
                           stars, with a call to the RGB Windows API function.
Version 1.04, 18/07/1998 - Added a call to the ProcessMessages method of the
                           application's main window to yield for other
                           events when plotting a large number of stars.
                           Added a call to the globular cluster plotting
                           procedure to the OnPaint and the OnResize
                           events. Beautified.
Version 1.05, 16/08/1998 - Fixed a bug that prevented the clearing of the main
                           window's display area when no stars was selected for
                           plotting. Recompiled in Delphi 3.0.
Version 2.00, 28/10/2019 - Converted to FreePascal 3.0.4/Lazarus 2.0.2.