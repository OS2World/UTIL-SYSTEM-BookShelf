� �� 0�   d   	Bookshelfe   n   �   ScanMe�   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   ,  BookFind-  3  4  5  .  ��� 0�2  BooksDefault�bookdat = bookdef
CALL SysIni bookcfg, 'Settings', 'Database', bookdat
IF STREAM(bookdat,'C','QUERY EXISTS') = '' THEN DO
    '@type nul >'||bookdat
    dummy = STREAM(bookdat, 'C', 'OPEN')
    CALL LINEOUT bookdat, LEFT('INF.BMP',10)||LEFT(prgname,100)||LEFT('Books.inf',30)||Directory()||'\Books.inf'
    dummy = STREAM(bookdat, 'C', 'CLOSE')
END
BookFind�book2find = STRIP(BookFind.C301.Text())
SELECT
    WHEN book2find = '' THEN dummy = BEEP(450,150)
    OTHERWISE DO
	ibook = TRANSLATE(book2find)
	DO f = 1 TO book2add.0
	    IF POS(ibook,TRANSLATE(STRIP(SUBSTR(book2add.f,11,100)))) > 0 THEN DO
		PARSE VALUE book2add.f WITH data.1+10 data.2+100 data.3+30 data.4
		data.0 = 4
		data.1 = STRIP(data.1)
		data.2 = STRIP(data.2)
		data.3 = STRIP(data.3)
		data.4 = STRIP(data.4)
		bookbmp = data.1
		item302 = BookFind.C302.Add(book2add.f,bookbmp)
		CALL BookFind.C302.SetStem 'data', item302
	    END
	END
	CALL BookFind.Text book2find||' - '||BookFind.C302.Item()||' '||msg.102
    END
ENDDataMenu�SELECT
    WHEN TRANSLATE(bookdat) = TRANSLATE(bookdef) THEN CALL Bookshelf.DataDel.MenuDisabled 1
    OTHERWISE CALL Bookshelf.DataDel.MenuDisabled 0
END	DataSave1S'@copy '||bookdat||' '||savedat
bookdat = savedat
CALL BooksRead
CALL BooksAdd
DataDel�IF RxMessageBox(msg.163,Menu2text(m.163)||' '||FILESPEC('name',bookdat)||'?','OKCancel','QUERY') = 1 THEN DO
    '@del '||bookdat
    bookdat = bookdef
    CALL BooksRead
    CALL BooksAdd
ENDDataSave�savedat = FilePrompt('*.DAT',msg.162,Menu2text(m.162),'S')
IF savedat <> '' THEN DO
    SELECT
	WHEN savedat = bookdat THEN NOP
	WHEN STREAM(savedat,'C','QUERY EXISTS') = '' THEN CALL DataSave1
	OTHERWISE DO
	    IF RxMessageBox(savedat||'0d0a'x||msg.1621,t.1621,'OKCancel','QUERY') = 1 THEN DO
		CALL DataSave1
	    END
	END
    END
ENDDataOpen�newdat = FilePrompt('*.DAT',msg.161||' '||prgname,Menu2text(m.161))
IF newdat <> '' THEN DO
    IF STREAM(newdat,'C','QUERY EXISTS') <> '' THEN DO
	bookdat = newdat
	CALL BooksRead
	CALL BooksAdd
    END
ENDChkAssoc�bookfilters = '*.INF *.HLP *.PDF *.PS'
assofilters = ''
CALL SysIni 'USER','PMWP_ASSOC_FILTER', 'ALL:', 'allasoc.'
DO t = 1 TO WORDS(bookfilters)
    DO a = 1 TO allasoc.0
	IF WORD(bookfilters,t) = TRANSLATE(allasoc.a) THEN DO
	    IF SysIni('USER','PMWP_ASSOC_FILTER',allasoc.a) <> '00'x THEN DO
		assofilters = assofilters||' '||WORD(bookfilters,t)
		LEAVE a
	    END
	END
    END
END
assotypes = STRIP(SPACE(TRANSLATE(assofilters,'  ','*.'),1))
assofilters = TRANSLATE(STRIP(assofilters),';',' ')
	BooksRead�book2add.0 = 0
b2add = 0
dummy = STREAM(bookdat, 'C', 'OPEN READ')
DO WHILE LINES(bookdat) > 0
    b2add = b2add + 1
    book2add.b2add = LINEIN(bookdat)
END
dummy = STREAM(bookdat, 'C', 'CLOSE')
book2add.0 = b2add

CALL DataMenu
BookFindClose*CALL BookFind.Close
CALL Bookshelf.EnableScanMeClose(CALL ScanMe.Close
CALL Bookshelf.EnableMenuText�CALL Bookshelf.MenuMain.MenuText m.100
CALL Bookshelf.MenuOpen.MenuText m.110
CALL Bookshelf.MenuFind.MenuText m.120
CALL Bookshelf.MenuAdd.MenuText m.130
CALL Bookshelf.MenuDel.MenuText m.140
CALL Bookshelf.MenuScan.MenuText m.150
CALL Bookshelf.MenuData.MenuText m.160
CALL Bookshelf.DataOpen.MenuText m.161
CALL Bookshelf.DataSave.MenuText m.162
CALL Bookshelf.DataDel.MenuText m.163
CALL Bookshelf.MenuSort.MenuText m.170
CALL Bookshelf.SortType.MenuText m.171
CALL Bookshelf.SortTitle.MenuText m.172
CALL Bookshelf.SortName.MenuText m.173
CALL Bookshelf.SortPath.MenuText m.174
CALL Bookshelf.SortAsc.MenuText m.178
CALL Bookshelf.SortDesc.MenuText m.179
CALL Bookshelf.MenuHelp.MenuText m.180
CALL Bookshelf.MenuExit.MenuText m.199	Menu2text�PARSE ARG menutxt
SELECT
    WHEN POS('~',menutxt) = 1 THEN menutxt = SUBSTR(menutxt,2)
    WHEN POS('~',menutxt) > 1 THEN menutxt = LEFT(menutxt,POS('~',menutxt)-1)||SUBSTR(menutxt,POS('~',menutxt)+1)
    OTHERWISE NOP
END
Return menutxtHelpMe'START /F View.exe Books.inf'	BookTitle�
PARSE ARG bookfile

bookfilen = FILESPEC('name',bookfile)
bookfilee = TRANSLATE(SUBSTR(bookfilen,LASTPOS('.',bookfilen)+1))
booktitle = ''
xtitle = ''

dummy = STREAM(bookfile, 'C', 'OPEN READ')
ftitle = CHARIN(bookfile,1,CHARS(bookfile))
dummy = STREAM(bookfile, 'C', 'CLOSE')

SELECT
    WHEN bookfilee = 'PDF' THEN DO
	IF SUBSTR(ftitle,1,4) = '%PDF' THEN DO
	    stitle = POS('/Title (',ftitle)
	    IF stitle > 0 THEN DO
		etitle = POS(')',ftitle,stitle+8)
		IF etitle > stitle THEN DO
		    xtitle = SUBSTR(ftitle,stitle+8,etitle-stitle-8)
		END
	    END
	END
    END
    WHEN bookfilee = 'PS' THEN DO
	IF SUBSTR(ftitle,1,4) = '%!PS' THEN DO
	    stitle = POS('%%Title:',ftitle)
	    IF stitle > 0 THEN DO
		etitle = POS('%',ftitle,stitle+8)
		IF etitle > stitle THEN DO
		    xtitle = SUBSTR(ftitle,stitle+8,etitle-stitle-8)
		END
	    END
	END
    END
    OTHERWISE DO
	IF SUBSTR(ftitle,1,3) = 'HSP' THEN DO
	    xtitle = SUBSTR(ftitle, 108, 100)
	    PARSE VALUE xtitle WITH xtitle '00'x trash
	END
    END
END
DROP ftitle
xtitle = STRIP(TRANSLATE(xtitle,'  ','0d0a'x))
SELECT
    WHEN xtitle = '' THEN mytitle = bookfilen||' '||t.101
    OTHERWISE mytitle = xtitle
END
booktitle = LEFT(bookfilee||'.BMP',10)||LEFT(mytitle,100)||LEFT(bookfilen,30)||bookfile

RETURN booktitleSortOptions�CALL Bookshelf.SortType.MenuChecked 0
CALL Bookshelf.SortTitle.MenuChecked 0
CALL Bookshelf.SortName.MenuChecked 0
CALL Bookshelf.SortPath.MenuChecked 0
CALL Bookshelf.SortAsc.MenuChecked 0
CALL Bookshelf.SortDesc.MenuChecked 0

SELECT
    WHEN rexxutil200 = 1 THEN DO
	CALL Bookshelf.MenuAdd.MenuDisabled 0
	CALL Bookshelf.MenuDel.MenuDisabled 0
	CALL Bookshelf.MenuSort.MenuDisabled 0
	SELECT
	    WHEN sort1 = 1 THEN CALL Bookshelf.SortType.MenuChecked 1
	    WHEN sort1 = 2 THEN CALL Bookshelf.SortTitle.MenuChecked 1
	    WHEN sort1 = 3 THEN CALL Bookshelf.SortName.MenuChecked 1
	    WHEN sort1 = 4 THEN CALL Bookshelf.SortPath.MenuChecked 1
	    OTHERWISE NOP
	END
	SELECT
	    WHEN sort2 = 'A' THEN CALL Bookshelf.SortAsc.MenuChecked 1
	    WHEN sort2 = 'D' THEN CALL Bookshelf.SortDesc.MenuChecked 1
	    OTHERWISE NOP
	END
    END
    OTHERWISE DO
	CALL Bookshelf.MenuAdd.MenuDisabled 1
	CALL Bookshelf.MenuDel.MenuDisabled 1
	CALL Bookshelf.MenuSort.MenuDisabled 1
    END
END	BooksSort�mysort = sort1||' '||sort2
IF rexxutil200 = 1 THEN DO
    SELECT
	WHEN sort1 = 1 THEN CALL SysStemSort 'book2add.', sort2, 'I',,, 1, 10
	WHEN sort1 = 2 THEN CALL SysStemSort 'book2add.', sort2, 'I',,, 11, 110
	WHEN sort1 = 3 THEN CALL SysStemSort 'book2add.', sort2, 'I',,, 111, 140
	WHEN sort1 = 4 THEN CALL SysStemSort 'book2add.', sort2, 'I',,, 141, 240
	OTHERWISE NOP
    END
END
CALL SortOptions
Init�IF RxFuncQuery('SysLoadFuncs') THEN DO
    CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
    CALL SysLoadFuncs
END
SELECT
    WHEN RxFuncQuery("SysUtilVersion") = 1 THEN rexxutil200 = 0
    WHEN SysUtilVersion() < "2.00" THEN rexxutil200 = 0
    OTHERWISE rexxutil200 = 1
END

prgname = 'Bookshelf 0.9.2'
bookcfg = Directory()||'\BOOKS.INI'
bookdef = Directory()||'\BOOKS.DAT'

BookAdd�addme = FilePrompt(assofilters,msg.130,Menu2text(m.130))
IF addme <> '' THEN DO
    newbook = BookTitle(addme)
    CALL SysStemInsert 'book2add.', book2add.0+1, newbook
    CALL BooksAdd
    CALL BooksWrite
ENDBookOpenKdummy = SysOpenObject(book2open, 'DEFAULT', '1')
CALL Bookshelf.C101.FocusBookDel�IF RxMessageBox(STRIP(seltitle)||'0d0a'x||msg.140,Menu2text(m.140)||'?','OKCancel','QUERY') = 1 THEN DO
    DO i = 1 TO book2add.0
	IF selbook = book2add.i THEN DO
	    CALL SysStemDelete "book2add.", i
	    LEAVE
	END
    END
    CALL BooksWrite
    SELECT
	WHEN seltype = 'INF' THEN infs = infs-1
	WHEN seltype = 'HLP' THEN hlps = hlps-1
	WHEN seltype = 'PDF' THEN pdfs = pdfs-1
	WHEN seltype = 'PS' THEN ps_s = ps_s-1
	OTHERWISE NOP
    END
    CALL BooksTitle
    CALL Bookshelf.C101.Delete EventData.1
ENDTheEnd�mypos =  xp||' '||yp||' '||xs||' '||ys
myfont = STRIP(TRANSLATE(C101.Font(),' ','00'x))
mycolor = STRIP(TRANSLATE(C101.Color(),' ','00'x))
mysort = sort1||' '||sort2
CALL CfgSave
BooksTitleibookstit = prgname||' - '||book2add.0||' '||msg.102||' ('||bookdat||')'
CALL Bookshelf.Text bookstit

	BooksList�bookok = 0
DO i = 1 TO allbooks.0
    booktitle = BookTitle(allbooks.i)
    IF booktitle <> '' THEN DO
	bookok = bookok+1
	book2add.bookok = booktitle
    END
END
book2add.0 = bookok
BooksWrite�'@type nul >'||bookdat
dummy = STREAM(bookdat, 'C', 'OPEN')
DO i = 1 TO book2add.0
    CALL LINEOUT bookdat, book2add.i
END
dummy = STREAM(bookdat, 'C', 'CLOSE')
BooksAdd�CALL Bookshelf.Text prgname||' - '||msg.101
CALL Bookshelf.C101.Hide
CALL Bookshelf.C101.Delete
infs = 0
hlps = 0
pdfs = 0
ps_s = 0
CALL BooksSort
DO i = 1 TO book2add.0
    PARSE VALUE book2add.i WITH data.1+10 data.2+100 data.3+30 data.4
    data.0 = 4
    data.1 = STRIP(data.1)
    data.2 = STRIP(data.2)
    data.3 = STRIP(data.3)
    data.4 = STRIP(data.4)
    SELECT
	WHEN data.1 = 'INF.BMP' THEN infs = infs+1
	WHEN data.1 = 'HLP.BMP' THEN hlps = hlps+1
	WHEN data.1 = 'PDF.BMP' THEN pdfs = pdfs+1
	WHEN data.1 = 'PS.BMP' THEN ps_s = ps_s+1
	OTHERWISE NOP
    END
    bookbmp = data.1
    myitem = Bookshelf.C101.Add(book2add.i,bookbmp)
    CALL Bookshelf.C101.SetStem 'data', myitem
END
CALL BooksTitle
CALL Bookshelf.C101.Show
CALL Bookshelf.C101.FocusCfgSave�CALL SysIni bookcfg, 'Settings', 'Database', bookdat
CALL SysIni bookcfg, 'Settings', 'Color', mycolor
CALL SysIni bookcfg, 'Settings', 'Font', myfont
CALL SysIni bookcfg, 'Settings', 'Position', mypos
CALL SysIni bookcfg, 'Settings', 'Sort', mysort


CfgDefault�bookdat = Directory()||'\BOOKS.DAT'
mycolor ='#0'
myfont = '9.WarpSans'
xs = 600
ys = 420
xp = (cx-xs)%2
yp = (cy-ys)%2
mypos = xp||' '||yp||' '||xs||' '||ys
sort1 = 2
sort2 = 'A'
mysort = sort1||' '||sort2
CALL CfgSave
CALL CfgLoadCfgLoad�bookdat = SysIni(bookcfg,'Settings', 'Database')
mycolor = SysIni(bookcfg,'Settings','Color')
myfont = SysIni(bookcfg,'Settings','Font')
mypos = SysIni(bookcfg,'Settings','Position')
mysort = SysIni(bookcfg,'Settings','Sort')

IF STREAM(bookdat,'C','QUERY EXISTS') = '' THEN DO
    CALL BooksDefault
END
SELECT
    WHEN mycolor = 'ERROR:' THEN CALL CfgDefault
    WHEN myfont = 'ERROR:' THEN CALL CfgDefault
    WHEN WORDS(mypos) <> 4 THEN CALL CfgDefault
    WHEN WORDS(mysort) <> 2 THEN CALL CfgDefault
    OTHERWISE DO
	DO i = 1 TO 4
	    IF DATATYPE(WORD(mypos,i)) <> 'NUM' THEN DO
	    	CALL CfgDefault
	    	LEAVE i
	    END
	END
    END
END

PARSE VALUE mypos WITH xp yp xs ys
PARSE VALUE mysort WITH sort1 sort2Language+CALL Lang100
CALL Lang200

CALL MenuTextLang100�	/* Dialog 100 - Bookshelf */

/* Menu */
m.100 = '~Bookshelf'
m.110 = '~Open book'
m.120 = '~Find book'
m.130 = '~Add book'
m.140 = '~Remove book'
m.150 = 'Scan ~drives'
m.160 = 'Data~base'
m.161 = '~Open'
m.162 = '~Save'
m.163 = '~Delete'
m.170 = '~Sort'
m.171 = 'T~ype'
m.172 = '~Title'
m.173 = '~File name'
m.174 = '~Path'
m.178 = '~Ascending'
m.179 = '~Descending'
m.180 = '~Help'
m.199 = 'E~xit'

/* Title */
t.1 = 'Type'
t.2 = 'Title'
t.3 = 'File name'
t.4 = 'Path and file name'

/* Text */
t.101 = '(untitled)'
t.110 = 'Please wait'
t.1621 = 'Database exists!'

/* Message */
msg.101 = "updating list!"
msg.102 = "books"
msg.103 = "extracting title:"
msg.104 = "searching books on drive"
msg.130 = "Add new book to the list"
msg.140 = "Select OK to remove this book from the list."
msg.161 = "Open new database (*.DAT file) to use with"
msg.162 = "Save this database (*.DAT file) under new name"
msg.1621 = "already exists. Select OK to overwrite existing database. Select Cancel to return to program."
msg.163 = "Select OK if you want to delete active database. Select Cancel to return to program."
msg.199 = "Your REXXUTIL.DLL is not at the current level (2.00). Following menu items will be disabled:"Lang200\/* Dialog 200 - ScanMe */

/* Text */
t.209 = "~Close"
t.210 = "Drives"
t.240 = "Books"ScanMe�CALL Bookshelf.Disable
DROP allbooks.
allbooks.0 = 0
allbook = 0
DO d = 1 TO WORDS(drv2scan)
    DO t = 1 TO WORDS(typ2scan)
	CALL Bookshelf.Text prgname||' - '||msg.104||' '||WORD(drv2scan,d) ||' - '||WORD(typ2scan,t)
	CALL SysFileTree WORD(drv2scan,d)||'\*.'||WORD(typ2scan,t), 'books', 'FSO'
	IF books.0 > 0 THEN DO
	    DO b = 1 TO books.0
		allbook = allbook+1
		allbooks.allbook = books.b
	    END
	END
	DROP books.
    END
END
allbooks.0 = allbook
IF allbooks.0 > 0 THEN DO
    CALL BooksList
    CALL BooksAdd
    CALL BooksWrite
END
CALL Bookshelf.Enable
CALL BooksTitleResizeMeCALL C110.Position fl, fb, xs-fl-fr, ys-ft2-fb*2
CALL C101.Position fl+2, fb+2, xs-fl-fr-4, ys-ft2-fb*2-4
CALL Bookshelf.Show�� �d 0�   �   �  ��         	 h   k M ;� d ��r       %   v     /� e w ��     �   �    �  6� n ����Bookshelf #             ����      ����CANVAS  � �d 0k  k  �      ~Books T  �      ~Open book     ~Find book     ~Add book     ~Delete book   @��   	 Scan ~drives    
 ~Database I   �      ~Open database     ~Save as ...     ~Delete database     ~Sort list d   �      T~ype     ~Title     ~Name     ~Path   @��    ~Ascending     ~Descending   @��    ~Help     E~xit ���d 0�   MenuMain  MenuOpenCALL BookOpen MenuFindCALL BookFind.Open MenuAddCALL BookAdd MenuDelCALL BookDel	 MenuScanCALL ScanMe.Open
 MenuData  DataOpenCALL DataOpen DataSaveCALL DataSave DataDelCALL DataDel MenuSort  SortTypesort1 = 1
CALL BooksAdd 	SortTitlesort1 = 2
CALL BooksAdd SortNamesort1 = 3
CALL BooksAdd SortPathsort1 = 4
CALL BooksAdd SortAscsort2 = 'A'
CALL BooksAdd SortDescsort2 = 'D'
CALL BooksAdd MenuHelpCALL HelpMe MenuExitCALL TheEnd
Exit���d 0�  �d Size@PARSE VALUE Bookshelf.Position() WITH xp yp xs ys
CALL ResizeMeExitCALL TheEndMove1PARSE VALUE Bookshelf.Position() WITH xp yp xs ysInit�PARSE VALUE ScreenSize() WITH cx cy
PARSE VALUE Bookshelf.Frame() WITH fl fb fr ft2
ft = ft2%2

CALL CfgLoad
CALL ChkAssoc
CALL Language
CALL C110.Text t.110
CALL Bookshelf.Range 600, 420, cx, cy
CALL Bookshelf.Position xp, yp, xs, ys
CALL Bookshelf.Font myfont
CALL ResizeMe

CALL C101.View "Detail"
stem.0 = 4
stem.1 = "X_="
stem.2 = "X_."
stem.3 = "X_!"
stem.4 = "X_"
CALL C101.SetStem 'stem', "F"
title.0 = 4
DO i = 1 TO title.0
    title.i = t.i
END
CALL C101.SetStem 'title', 0
CALL C101.Color '-',mycolor

IF STREAM(bookdat,'C','QUERY EXISTS') = '' THEN DO
    CALL BooksDefault
END

CALL BooksRead
CALL BooksAdd

IF rexxutil200 = 0 THEN DO
    errmsg = msg.199||'0d0a'x||Menu2text(m.130)||'0d0a'x||Menu2text(m.140)||'0d0a'x||Menu2text(m.170)
    IF RxMessageBox(errmsg,'Oops!',,'WARNING') = 1 THEN DO
    END
END�e Enter�CALL EventData
IF EventData.1>0 & EventData.2='+SELECT' THEN DO
    selbook = item(EventData.1)
    PARSE VALUE selbook WITH seltype+10 seltitle+100 selname+30 book2open
    CALL BookOpen
END
ShowMenu!CALL Bookshelf.MenuMain.MenuPopUpSelect�CALL EventData
IF EventData.1>0 & EventData.2='+SELECT' THEN DO
    selbook = item(EventData.1)
    PARSE VALUE selbook WITH seltype+10 seltitle+100 selname+30 book2open
END
�� �� 0[  [  �  ��           ��  � i � m � ���        �  	 U   � ����        �  	 J   � ����        �  	 ?   � ����        �  	 4   � ����        �  # U   � ����        �  # J   � ����          # ?   � ����          # 4   � ����          = U   � ����          = J   � ����        	  = ?   � ����          = 4   � ����          W U   � ����          W J   � ����          W ?   � ����          W 4   � ����          q U   � ����          q J   � ����          q ?   � ����          q 4   � ����          � U   � ����          � J   � ����        !  � ?   � ����        #  � 4   � ����        % �1  )  � ����        ) �	  )  � ����        - �[  )  � ����        1 ��  )  � ����        4  �	  @  � ����        9  �i  @  � ����     @ G % � 1 � 8 � ����     N U % �  �  � ����Scan    C I O U D J P V E K Q W F L R X G M S Y H N T Z HLP INF PDF PS Scan Cancel CANVAS Drives CANVAS Books ���� 0�
  �� Key�CALL EventData
preskey = EventData.1
SELECT
    WHEN preskey = 'F1' THEN CALL HelpMe
    WHEN preskey = 'ESC' THEN CALL ScanMeClose
    OTHERWISE NOP
ENDInit�CALL Bookshelf.Disable
alldrives = SysDriveMap('C')

xs200 = xs%2
ys200 = fb+ft*10
xp200 = xp+xs%4
yp200 = yp+ys%4
CALL ScanMe.Position xp200, yp200, xs200, ys200
sx1 = (xs200-fl*5)%2

CALL C208.Position fl, fb, xs200%5*2, ft+fb
CALL C209.Position xs200%5*3-fr, fb, xs200%5*2, ft+fb

xp240 = fl
yp240 = fb*3+ft
xs240 = xs200-fl-fr
ys240 = ft*2+fb
CALL C240.Position xp240, yp240, xs240, ys240
DO i = 241 TO 244
    INTERPRET 'CALL C'||i||'.Position xp240+fl+xs240%4*(i-241), yp240+fb, xs240%4-fr*2, ft'
    INTERPRET 'mytyp = C'||i||'.Text()'
    SELECT
	WHEN WORDPOS(mytyp,assotypes) = 0 THEN DO
	    INTERPRET 'CALL C'||i||'.Disable'
	    INTERPRET 'CALL C'||i||'.Select 0'
	END
	OTHERWISE DO
	    INTERPRET 'CALL C'||i||'.Enable'
	    INTERPRET 'CALL C'||i||'.Select 1'
	END
    END
END

xp210 = xp240
yp210 = yp240+ys240
xs210 = xs240
ys210 = ys200-yp210-ft-1
CALL C210.Position xp210, yp210, xs210, ys210
bxs = (xs210-fl-fr)%6
DO i = 1 TO 24
    SELECT
	WHEN i//6 = 0 THEN bxp = xp210+fl+bxs*5
	OTHERWISE bxp = xp210+fl+bxs*(i//6-1)
    END
    SELECT
	WHEN i > 18 THEN byp = yp210+fb
	WHEN i > 12 THEN byp = yp210+fb+ft
	WHEN i > 6 THEN byp = yp210+fb+ft*2
	OTHERWISE byp = yp210+fb+ft*3
    END
    bid = i+210
    drv = D2C(i+66)||':'
    INTERPRET 'CALL C'||bid||'.Position bxp, byp, bxs, ft'
    IF POS(drv,alldrives) > 0 THEN DO
	INTERPRET 'CALL C'||bid||'.Show'
	INTERPRET 'CALL C'||bid||'.Disable'
	INTERPRET 'CALL C'||bid||'.Text drv'
	IF SysDriveInfo(drv) <> '' THEN DO
	    INTERPRET 'CALL C'||bid||'.Enable'
	END
	IF POS(drv,TRANSLATE(Directory())) = 1 THEN DO
	    INTERPRET 'CALL C'||bid||'.Select 1'
	END
    END
END

CALL C208.Focus

CALL ScanMe.Text Menu2text(m.150)
CALL C208.Text Menu2text(m.150)
CALL C209.Text t.209
CALL C210.Text t.210
CALL C240.Text t.240||' - '||t.1
CALL ScanMe.Show�� ClickCALL ScanMeClose�� Click�drv2scan = ''
DO i = 1 TO 24
    bid = 210+i
    INTERPRET 'mysel = C'||bid||'.Select()'
    IF mysel = 1 THEN DO
	drv2scan = drv2scan||D2C(i+66)||': '
    END
END
drv2scan = STRIP(drv2scan)

typ2scan = ''
DO i = 241 TO 244
    INTERPRET 'mysel = C'||i||'.Select()'
    IF mysel = 1 THEN DO
	INTERPRET 'mytyp = C'||i||'.Text()'
	typ2scan = typ2scan||mytyp||' '
    END
END
typ2scan = STRIP(typ2scan)

SELECT
    WHEN drv2scan = '' THEN dummy = BEEP(450,150)
    WHEN typ2scan = '' THEN dummy = BEEP(450,150)
    OTHERWISE DO
	CALL ScanMe.Close
	CALL ScanMe
    END
END�� �,0�   �   �  ��          � �  p R 1� ,���          �  � � d 
 -����        �   �p � =  3����        �   �� � =  4����        �   �� � :  5����      %   �  �  )� .� ��BookFind     Find Clear Close           ����      �������,0�  �,Key�CALL EventData
preskey = EventData.1
SELECT
    WHEN preskey = 'F1' THEN CALL HelpMe
    WHEN preskey = 'ESC' THEN CALL BookFindClose
    OTHERWISE NOP
ENDInit�CALL Bookshelf.Disable

xs300 = xs-fl*2
ys300 = ys-fb*2
CALL BookFind.Position xp+fl, yp+fb, xs300, ys300
CALL BookFind.Text Menu2text(m.120)||' - '||t.2

CALL C301.Position fl, ys300-ft2-fb-2, xs300%2-fl*2, ft
DO i = 307 TO 309
    INTERPRET 'CALL C'||i||'.Position xs300-xs300%6*(310-i), ys300-ft2-fb*2, xs300%6-fr, ft+fb'
END
CALL C307.Text m.120
CALL C309.Text t.209

CALL C302.Position fl, fb, xs300-fl-fr, ys300-ft2-fb*4
CALL C302.View "Detail"
stem.0 = 4
stem.1 = "X_="
stem.2 = "X_."
stem.3 = "X_!"
stem.4 = "X_"
CALL C302.SetStem 'stem', "F"
title.0 = 4
DO i = 1 TO title.0
    title.i = t.i
END
CALL C302.SetStem 'title', 0

CALL BookFind.Show�.Enter�CALL EventData 'data302'
IF data302.1>0 & data302.2='+SELECT' THEN DO
    item302 = Item(data302.1)
    PARSE VALUE item302 WITH type302+10 title302+100 name302+30 book302
    dummy = SysOpenObject(book302, 'DEFAULT', '1')
END
Select�CALL EventData 'data302'
IF data302.1>0 & data302.2='+SELECT' THEN DO
    item302 = Item(data302.1)
    PARSE VALUE item302 WITH type302+10 title302+100 name302+30 book302
END
�5ClickCALL BookFindClose�4ClickzCALL C301.Text ''
CALL C302.Hide 'N'
CALL C302.Delete
CALL C302.Show
CALL BookFind.Text Menu2text(m.120)||' - '||t.2
�3ClickCCALL C302.Hide 'N'
CALL C302.Delete
CALL C302.Show
CALL BookFind�