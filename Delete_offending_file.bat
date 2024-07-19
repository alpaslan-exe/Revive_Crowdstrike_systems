REM dependencies: Wolcmd and PsExec 

@echo off
REM Set the paths to the tools
set WOLCMD_PATH=C:\path\to\wolcmd.exe
set PSEXEC_PATH=C:\path\to\PsExec.exe

REM Set this to the list of MAC addresses and  IP addresses of remote machines
set MACS=XX-XX-XX-XX-XX-XX YY-YY-YY-YY-YY-YY ZZ-ZZ-ZZ-ZZ-ZZ-ZZ
set IPs=192.168.1.255 192.168.1.255 192.168.1.255

REM File path to be deleted on remote PCs SET THIS TO OFFENDING FILE ON MACHINE
set FILE_PATH=C:\path\to\file

:wake_and_delete
setlocal
set MAC=%1
set IP=%2

echo Waking up PC with MAC %MAC% and IP %IP%...
%WOLCMD_PATH% %MAC% %IP% 9

REM booting into safe mode, give it time 
timeout /t 100

set TEMP_SCRIPT=%TEMP%\delete_file_and_reboot.bat
(
    echo @echo off
    echo if exist %FILE_PATH% (
    echo    del %FILE_PATH%
    echo    echo File deleted successfully.
    echo ) else (
    echo    echo File not found.
    echo )
    echo bcdedit /deletevalue {current} safeboot
    echo shutdown /r /t 0
) > %TEMP_SCRIPT%

REM PsExec delete 
echo Running delete script on remote PC with IP %IP%...
%PSEXEC_PATH% \\%IP% -u remote-username -p remote-password -h -i %TEMP_SCRIPT%

endlocal
goto :eof

REM loop for the whole IP list
set i=0
for %%A in (%MACS%) do (
    set /A i+=1
    for /F "tokens=%i%" %%B in ("%IPs%") do (
        call :wake_and_delete %%A %%B
    )
)

REM once the dust settles
echo All tasks completed.
pause
