::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFA9VQgqHAE+/Fb4I5/jH+++UtnE+WOc+dorJlLGWJYA=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off 
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
:menu
:z
cls
Echo Please Enter one of the options below.
echo.
 
Echo Enter 1 : Change BIOS Information.
Echo Enter 2 : Change Computer Name.
Echo Enter 3 : Clean Modern Warfare Files.
Echo Enter 4 : Clean Cold War Files.
Echo Enter 5 : Clean Registry Files.
Echo Enter 6 : Change Network Macaddress.
Echo Enter 7 : Exit
echo.
echo.


set /p ans="Enter Number:"


if %ans%==1 (
goto 1
)
if %ans%==2 (
goto 2
)
if %ans%==3 (
goto 3
)
if %ans%==4 (
goto 4
)
if %ans%==5 (
goto 5
)  
if %ans%==6 (
goto 6
)  

:1
sc stop AMIFLDRV64
sc delete AMIFLDRV64
set location=%~dp0
start %location%\dsefix.exe
sc create AMIFLDRV64 binpath=%location%\AMIFLDRV64.sys type=kernel
sc start AMIFLDRV64
start %location%\dsefix.exe -e
pause
%location%\AMIDEWINx64.exe /SU
%location%\AMIDEWINx64.exe /SS
%location%\AMIDEWINx64.exe /BS
%location%\AMIDEWINx64.exe /CS
pause
sc stop AMIFLDRV64
sc delete AMIFLDRV64
cls
goto menu
Exit


:2
echo off
setlocal EnableDelayedExpansion
set charSets=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
set count=0

set /a countRaw=1

for /L %%c in (1,1,%countRaw%) do (call :MAKERANDOMSTRING)
goto ENDRANDOMSTRING;

:MAKERANDOMSTRING
set buffer=% %
set count=0
set /a lowValue=30+(%random%)%%40
set /a length=5
:Loop
set /a count+=1
set /a rand=%Random%%%69
set buffer=!buffer!!charSets:~%rand%,1!
if !count! leq !length! goto Loop
:ENDRANDOMSTRING
FOR /F "tokens=*" %%g IN ('hostname') do (SET VAR=%%g)

wmic computersystem where caption="%VAR%" rename %buffer%
cls
echo. Old Computer Name: %VAR%
echo. New Computer Name: %buffer%
pause
cls
goto menu


:3
echo Please Select the ModernWarfare.exe file
echo Example: C:\Program Files (x86)\Call of Duty Modern Warfare\ModernWarfare.exe
@timeout /t 2 /nobreak
call :filedialogMW file
set folder=%file:ModernWarfare.exe=%
echo %folder%
pause
:MWFiles
taskkill /IM "Agent.exe" /F
taskkill /IM "Battle.net.exe" /F
del /S /F /Q "%folder%main\data0.dcache"
del /S /F /Q "%folder%main\data1.dcache"
del /S /F /Q "%folder%main\toc0.dcache"
del /S /F /Q "%folder%main\toc1.dcache"
del /S /F /Q "%folder%Data\data\shmem"
del /S /F /Q "%folder%main\recipes\cmr_hist"
goto menu


:filedialogMW :: &file
setlocal 
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
endlocal  & set %1=%file%
goto MWFiles



:4
echo Please Select the BlackOpsColdWar.exe file
echo Example: C:\Program Files (x86)\Call of Duty Black Ops Cold War\BlackOpsColdWar.exe
call :filedialogCW file
set folder=%file:BlackOpsColdWar.exe=%
echo %folder%
pause
:CWFiles
taskkill /IM "Agent.exe" /F
taskkill /IM "Battle.net.exe" /F
del /S /F /Q "%folder%main\data0.dcache"
del /S /F /Q "%folder%main\data1.dcache"
del /S /F /Q "%folder%main\toc0.dcache"
del /S /F /Q "%folder%main\toc1.dcache"
del /S /F /Q "%folder%Data\data\shmem"
del /S /F /Q "%folder%main\recipes\cmr_hist"
cls
goto menu

:filedialogCW :: &file
setlocal 
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
endlocal  & set %1=%file%
goto CWFiles

:5
del /f ".\Data\data\shmem"
del /f ".\main\recipes\cmr_hist"
rmdir ".\main\recipes\cmr_hist" /s /q
rmdir "%userprofile%\documents\Call of Duty Modern Warfare" /s /q
rmdir "%userprofile%\documents\Call of Duty Cold War" /s /q
rmdir "%localappdata%\Battle.net" /s /q
rmdir "%localappdata%\Blizzard Entertainment" /s /q
rmdir "%appdata%\Battle.net" /s /q
rmdir "%programdata%\Battle.net" /s /q
rmdir "%programdata%\Blizzard Entertainment" /s /q
rmdir "%Documents%\Call Of Duty Modern Warfare" /s /q
reg delete "HKEY_CURRENT_USER\Software\Blizzard Entertainment" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Blizzard Entertainment" /f
reg delete "HKEY_CURRENT_USER\Software\Blizzard Entertainment\Battle.net\Identity" /f
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\InstallTime" /f
cls
goto menu


:6
echo.
echo. ----Old MAC Addresses----
getmac
echo. Changing the MAC Addresses...
Call :StartMAC
echo
echo. ----New MAC Addresses----
getmac
pause
cls
goto menu

:StartMAC
SETLOCAL ENABLEDELAYEDEXPANSION
SETLOCAL ENABLEEXTENSIONS

::Generate and implement a random MAC address
FOR /F "tokens=1" %%a IN ('wmic nic where physicaladapter^=true get deviceid ^| findstr [0-9]') DO (
CALL :MAC
FOR %%b IN (0 00 000) DO (
REG QUERY HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a >NUL 2>NUL && REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a /v NetworkAddress /t REG_SZ /d !MAC!  /f >NUL 2>NUL
)
)
::Disable power saving mode for network adapters
FOR /F "tokens=1" %%a IN ('wmic nic where physicaladapter^=true get deviceid ^| findstr [0-9]') DO (
FOR %%b IN (0 00 000) DO (
REG QUERY HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a >NUL 2>NUL && REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a /v PnPCapabilities /t REG_DWORD /d 24 /f >NUL 2>NUL
)
)

::Reset NIC adapters so the new MAC address is implemented and the power saving mode is disabled.
FOR /F "tokens=2 delims=, skip=2" %%a IN ('"wmic nic where (netconnectionid like '%%') get netconnectionid,netconnectionstatus /format:csv"') DO (
netsh interface set interface name="%%a" disable >NUL 2>NUL
netsh interface set interface name="%%a" enable >NUL 2>NUL
)

GOTO :EOF
:MAC
::Generates semi-random value of a length according to the "if !COUNT!"  line, minus one, and from the characters in the GEN variable
SET COUNT=0
SET GEN=ABCDEF0123456789
SET GEN2=26AE
SET MAC=
:MACLOOP
SET /a COUNT+=1
SET RND=%random%
::%%n, where the value of n is the number of characters in the GEN variable minus one.  So if you have 15 characters in GEN, set the number as 14
SET /A RND=RND%%16
SET RNDGEN=!GEN:~%RND%,1!
SET /A RND2=RND%%4
SET RNDGEN2=!GEN2:~%RND2%,1!
IF "!COUNT!"  EQU "2" (SET MAC=!MAC!!RNDGEN2!) ELSE (SET MAC=!MAC!!RNDGEN!)
IF !COUNT!  LEQ 11 GOTO MACLOOP 