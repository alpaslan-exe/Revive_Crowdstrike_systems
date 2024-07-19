REM request staff place machines into safe mode through email instructions, collect IPs, place in script and mass fix 
REM Dependencies competent staff 
@echo off
setlocal enabledelayedexpansion

REM change file path to offending file
set "BATCH_FILE_CONTENT=@echo off
echo Deleting files...
del /Q /F \"C:\path\to\files\*\"
echo Restarting computer...
shutdown /r /t 0"
set "REMOTE_BATCH_PATH=C$\path\to\cleanup_and_restart.bat"

REM IP lit
set "COMPUTERS=PC1 PC2 PC3"  :: Add your computer names or IPs here

REM Do this for x computers loop
for %%C in (%COMPUTERS%) do (
    echo Processing %%C
    echo !BATCH_FILE_CONTENT! > "%TEMP%\cleanup_and_restart.bat"
    echo Copying batch file to %%C...
    copy "%TEMP%\cleanup_and_restart.bat" "\\%%C\%REMOTE_BATCH_PATH%"
    echo Executing batch file on %%C...
    wmic /node:%%C process call create "cmd.exe /c %REMOTE_BATCH_PATH%"

    del "%TEMP%\cleanup_and_restart.bat"
)

endlocal
echo All done!
pause
