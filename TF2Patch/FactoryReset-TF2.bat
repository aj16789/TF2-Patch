@echo off

::We don't want people running this in the wrong place
IF NOT EXIST ".\hl2.exe" (
	ECHO Game binary doesn't exist. Are you executing this script from the wrong directory?
	CHOICE /N /M "Do you wish to continue? [Y/N]"

IF ERRORLEVEL == 2 (
	ECHO Aborting.
	EXIT /B 1
)

)

::Give the user fair warning
ECHO THIS IS WORK IN PROGRESS
ECHO.
ECHO This script will attempt to reset Team Fortress 2 to its default state. If the game is running, it will be closed.
ECHO You will lose any settings that have been changed and potentially any saved data, such as Configs.
::ECHO Customs will not be removed.
ECHO Customs will be removed.
ECHO.

::Let the user bail
CHOICE /N /M "Are you sure you want to continue? [Y/N]"

IF ERRORLEVEL == 2 (
	ECHO Aborting.
	EXIT /B 1
)

ECHO.

::Let the user bailx2
CHOICE /N /M "Are you really sure you want to continue? [Y/N]"

IF ERRORLEVEL == 2 (
	ECHO Aborting.
	EXIT /B 1
)

ECHO.

::Some of the below won't work if the game is already running
TASKKILL /f /im "hl2.exe" >NUL 2>&1
TASKKILL /f /im "hl2.exe" >NUL 2>&1
TASKKILL /f /im "hl2.exe" >NUL 2>&1

::Config files
ECHO [1/3] Removing configuration
CALL :DEL_DIR ".\tf\cfg"
CALL :DEL_DIR ".\tf\custom"
CALL :DEL_DIR ".\tf\screenshots"

::Server downloads
ECHO [2/3] Removing downloaded server content
CALL :DEL_DIR ".\tf\download"
CALL :DEL_DIR ".\tf\downloadlists"

::Get steam to redownload anything we've just deleted (this actually also deletes cfg/config.cfg from the Steam Cloud)
ECHO [3/3] Marking game's content for validation by Steam
::.\hl2.exe -factoryresetstuff
.\hl2.exe -autoconfig

ECHO.
ECHO Finished. Steam will attempt to download some missing files the next time you launch Team Fortress 2.
ECHO.

PAUSE
EXIT /B

:DEL_DIR
    ::ECHO Removing dir %1.
    IF EXIST %1 ( RMDIR /S /Q %1 )
    GOTO:EOF

:DEL_FILE
    ::ECHO Removing file %1.
    IF EXIST %1 ( DEL /Q %1 )
    GOTO:EOF