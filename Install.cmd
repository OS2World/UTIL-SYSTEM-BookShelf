/* Install / UnInstall for Bookshelf */

PARSE ARG action
IF RxFuncQuery('SysLoadFuncs') THEN DO
    CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
    CALL SysLoadFuncs
END
CALL SysCls
action = TRANSLATE(LEFT(action,1))
SELECT
    WHEN action = 'I' THEN CALL InstallMe
    WHEN action = 'U' THEN CALL UnInstallMe
    OTHERWISE CALL WhatAction
END
Exit /* End of Install.cmd */

/* WhatAction - no action selected */

WhatAction:     PROCEDURE

CALL SysCls
SAY 'Please enter installation parameter (I=Install, U=UnInstall, other=Exit):'
PARSE PULL action
SELECT
    WHEN TRANSLATE(LEFT(action,1)) = 'I' THEN CALL InstallMe
    WHEN TRANSLATE(LEFT(action,1)) = 'U' THEN CALL UnInstallMe
    OTHERWISE CALL NoAction 'Installation failed.'
END
RETURN /* End of WhatAction */

/* NoAction - abort Install */

NoAction:   PROCEDURE

CALL SysCls
PARSE ARG noinstmsg
SAY noinstmsg
SAY 'Press Enter to exit ...'
PULL answer
CALL SysCls
Exit /* End of NoAction */

/* InstallMe - install Bookshelf */

InstallMe:  PROCEDURE

prgname = 'Bookshelf 0.9.2'

CALL SysCls
SAY 'Welcome to '||prgname||' Installation procedure!'
SAY 'This procedure will create object for '||prgname||' on your Desktop,'
SAY 'Press "Y" (and Enter) to start Installation, Enter to exit...'
PARSE PULL answer

IF TRANSLATE(LEFT(answer,1)) <> "Y" THEN DO
    CALL NoAction 'Installation aborted'
END

SAY ' '
InstallDir = Directory()
WorkDir = Directory()

ProgTitle = prgname
EXE = 'Books.exe'
ICO = 'Books.ico'
Setup = 'OBJECTID=<BOOKSHELF_PROGRAM>;EXENAME='InstallDir'\'EXE';ICONFILE='InstallDir'\'ICO';STARTUPDIR='WorkDir''
Action = 'U'
dummy = SysCreateObject('WPProgram',ProgTitle,'<WP_DESKTOP>',Setup,Action)
SAY 'Creating '||prgname||' Program object - '||Rc2(dummy)

SAY ' '
SAY 'Installation finished! Press Enter to continue'
PULL answer
CALL SysCls
'START /F View.exe Books.inf Introduction'
RETURN /* End of InstallMe */

/* UnInstallMe - uninstall Bookshelf */

UnInstallMe: PROCEDURE

prgname = 'Bookshelf 0.9.2'
CALL SysCls
SAY 'This is '||prgname||' UnInstallation procedure!'
SAY 'This procedure will destroy '||prgname||' Program object'
SAY 'Press "Y" (and Enter) to start UnInstall, any other key to exit...'
PULL answer
IF answer <> "Y" THEN DO
    CALL NoAction 'UnInstall terminated.'
END
SAY ' '
SAY 'Destroying Program object'
CALL SysDestroyObject '<BOOKSHELF_PROGRAM>'
SAY ' '
SAY 'UnInstallation complete.'
SAY 'You can delete files in directory '||Directory()
SAY 'To install '||prgname||' again, start Install I. Press Enter to exit...'
PULL answer
RETURN /* End of UnInstallMe */

/* Rc2 - return code - SysCreateObject */

Rc2:        PROCEDURE

PARSE ARG rcSysCreateObject
SELECT
    WHEN rcSysIni = 0 THEN rc2 = 'Error'
    OTHERWISE rc2 = 'OK'
END
RETURN rc2 /* End of Rc2 */
