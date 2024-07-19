@echo off

REM List of IPs of remote machines
set IPs=192.168.1.101 192.168.1.102 192.168.1.103

set REBOOT_COUNT=15

:reboot_pc
setlocal
set IP=%1

echo Rebooting PC with IP %IP%...
shutdown /m \\%IP% /r /f /t 0

endlocal
goto :eof

REM Loop through the IP list
for /L %%i in (1,1,%REBOOT_COUNT%) do (
    echo Reboot iteration %%i
    for %%A in (%IPs%) do (
        call :reboot_pc %%A
    )
    timeout /t 60
)

echo All reboots completed.
pause
