.*
:userdoc.
:title. Bookshelf Version 0.9.2
:docprof toc=12.
.*
.* Panel definition : Introduction
.*
:h1 id=100  res=100 x=0% y=0% width=100% height=100%  group=1.Introduction
:i1 id=100.Introduction
:p.
Bookshelf will scan your drive(s) and find online books and help files (INF, HLP, PDF and PS files).
Information about found books can be saved in separate databases (*.DAT files).
:p.
This program does not need any install procedure and does not change your system files (CONFIG.SYS and system INI files).
.br
If you want to create program object on Desktop, run :hp9.Install.cmd:ehp9. Rexx script with parameter :hp9.I:ehp9..
.br
To uninstall Bookshelf, run :hp9.Install.cmd:ehp9. Rexx script again with parameter :hp9.U:ehp9. to destroy program object on Desktop. Then you can delete all files in Bookshelf directory.
:p.
:hp7.Requirements&colon.:ehp7.
:ol compact.
:li.OS/2 Version 3 or above.
:li.RexxUtil.dll Version 2.00 is recommended. If you have RexxUtil.dll version prior to 2.00, following menu items will be disabled&colon.
.br
 :hp2.Add book:ehp2., :hp2.Remove book:ehp2. and :hp2.Sort:ehp2..
:li.Associated programs for following file filters&colon. *.INF *.HLP *.PDF *.PS.
To check, and optionally change associations set, use Association Editor by Henk Kelder. You can find Association Editor on&colon.
:dl compact tsize=20.
:dt.Henks home page&colon.
:dd.:link reftype=launch object='Netscape.exe' data='http://www.os2ss.com/information/kelder'.http&colon.//www.os2ss.com/information/kelder/:elink.
:dt.Hobbes&colon.
:dd.:link reftype=launch object='Netscape.exe' data='http://hobbes.nmsu.edu/pub/os2/util/system/'.http&colon.//hobbes.nmsu.edu/pub/os2/util/system/:elink.
:edl.
:eol.
:p.
On first start, Bookshelf will scan drive where it is installed, build default database (BOOKS.DAT) and display all found INF, HLP, PDF and PS file in the list sorted by title.
:p.
Source code for Bookshelf is included in file source.zip.
.*
.* Panel definition : Usage
.*
:h1 id=200  res=200 x=0% y=0% width=100% height=100%  group=1.Usage
:i1 id=200.Usage
:p.
Books (files) are displayed in the list, with following information in columns&colon.
:parml compact tsize=5.
:pt.:hp2.Type:ehp2.
:pd.:artwork name='INF.BMP' runin.INF (OS/2 online books)   :artwork name='HLP.BMP' runin.HLP (OS/2 help files)   :artwork name='PDF.BMP' runin.PDF (Portable Document Format - Acrobat Document)   :artwork name='PS.BMP' runin. PS (Postscript)
:pt.:hp2.Title:ehp2.
:pd.Book's title
:pt.:hp2.Name:ehp2.
:pd.File name
:pt.:hp2.Path:ehp2.
:pd.File path and name
:eparml.
:p.
:hp7.Menu:ehp7. - press :hp9.Alt-B:ehp9., or right-click on the list.
:parml compact tsize=5.
:pt.:hp2.Open book:ehp2.
:pd.Open selected book with associated program. Also double-click on selected book.
:pt.:hp2.Find book:ehp2.
:pd.In new window, type string to find in titles, then click on button :hp9.Find book:ehp9..
In the list below will be displayed all found books. Double-click on selected book to open.
Click on :hp9.Clear:ehp9. button to delete text in entry field and books in the list.
Click on :hp9.Close:ehp9. button or press :hp9.Esc:ehp9. key to return to main window.
:pt.:hp2.Add book:ehp2.
:pd.Add new book to the list.
:pt.:hp2.Remove book:ehp2.
:pd.Remove selected book from the list.
:pt.:hp2.Scan drives:ehp2.
:pd.In new window, select drives to scan (default is drive where Bookshelf is installed) and books (INF, HLP, PDF, PS - default is all).
After you select drives and books, click on button :hp9.Scan drives:ehp9..
Click on :hp9.Close:ehp9. button or press :hp9.Esc:ehp9. key to return to main window.
:pt.:hp2.Database:ehp2.
:pd.Bookshelf can keep information about books in separate databases (*.DAT files).
Name of active (selected) database is displayed in title bar.
You can open another database, save selected database under new name, delete database.
After you delete database, default database (BOOKS.DAT) is opened.
You can not delete default database BOOKS.DAT.
:pt.:hp2.Sort:ehp2.
:pd.Sort books in the list by type, title, name or path, in ascending or descending order.
:pt.:hp2.Help:ehp2.
:pd.Show help (this file).
:pt.:hp2.Exit:ehp2.
:pd.Leave program.
:eparml.
:warning.
Menu items :hp2.Add book:ehp2., :hp2.Remove book:ehp2. and :hp2.Sort:ehp2. will be enabled only if you have RexxUtil.dll version 2.00.
:ewarning.

.*
.* Panel definition : Customization
.*
:h1 id=300  res=300 x=0% y=0% width=100% height=100%  group=1.Customization
:i1 id=300.Customization
:p.
You can customize Bookshelf&colon.
:ul compact.
:li.Position and size of Bookshelf window
:li.Font&colon. open Font Palette, drag and drop font on the list
:li.Background color&colon. open Color Palette, drag and drop color on the list
:eul.
:p.
Bookshelf will save changes on exit.
:nt.
If you want to use default settings (size 560*420, font 9.WarpSans, white background, database BOOKS.DAT), exit program, delete file BOOKS.INI and start program again.
:ent.
.*
.* Panel definition : Source code
.*
:h1 id=400  res=400 x=0% y=0% width=100% height=100%  group=1.Source code
:i1 id=400.Source code
:p.
Source code for Bookshelf is included - unzip file source.zip.
:p.
Thanks to Bj”rn S”derstr”m who translated Bookshelf to Swedish.
:p.
To modify source (Books.RES), you need DrDialog, a visual programming environment for REXX.
.br
You can :link reftype=launch object='Netscape.exe' data='http://hobbes.nmsu.edu/pub/os2/dev/rexx/drdialog.zip'.download DrDialog from Hobbes:elink..
:p.
To modify help file (Books.ipf), you need any text editor and IPF Compiler to write INF file.
:nt.
If you modify source, I would appreciate a copy of any changes.
:ent.
.*
.* Panel definition : Copyright and license
.*
:h1 id=900  res=900 x=0% y=0% width=100% height=100%  group=1.Copyright and license
:i1 id=900.Copyright and license
:dl compact tsize=15.
:dthd.:hp2.Author:ehp2.
:ddhd.Goran Ivankovic
:dt.:hp2.Address:ehp2.
:dd.Ulica Josipa Poduje 8
:dt.
:dd.HR-52100 Pula
:dt.
:dd.Croatia
:dt.:hp2.email:ehp2.
:dd.:link reftype=launch object='netscape.exe' data='mailto:duga1@pu.hinet.hr?subject=Bookshelf'.duga1@pu.hinet.hr:elink.
:dt.:hp2.Home page:ehp2.
:dd.:link reftype=launch object='Netscape.exe' data='http://www.os2world.com/goran/'.http&colon.//www.os2world.com/goran/:elink.
:edl.
:p.
This program is provided free under the terms of the GPL. You can use it, modify it and distribute it.
If you modify or distribute it the new source must accompany the distribution.
I would appreciate a copy of any changes.
.br
You may not distribute :hp2.Bookshelf 0.9.2:ehp2. in any way which leads to your making a profit from it.
:p.
The author makes no representations about the accuracy or suitability of
this material for any purpose. It is provided "as is", without any
express or implied warranties. The author will assume no liability for
damages either from the direct use of this product or as a consequence of
the use of this product.
:ul compact.
:li.OS/2 is Trademark of International Bussines Machines Corporation
:li.DrDialog is Copyright of International Bussines Machines Corporation
:li.Association Editor is Copyright of Henk Kelder
:eul.
:euserdoc.
