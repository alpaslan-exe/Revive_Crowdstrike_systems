# Revive_Crowdstrike_systems
This is a developing fix to mass revive PCs affected by the forced update that bricked millions of PCs. 

This solution will only work if the device affected supports BIOS level RDP wake-on-lan. 
This script will:
1. Boot the PC in safe mode
2. delete the offending file
3. restart the PC to normal function

Alternatively, I will provide a script that automates the Microsoft suggested solution of starting and restarting the machine 15 times
These scripts will be automated to enable batch fixes of the corrupted machines. 
This is an ongoing project, please review the code prior to running, the script is simple, I am not responsible for your machine.

If you are able to add onto the code please open a pull request, I will monitor this github as long as the outage proceeds. 
This is all done through volunteer work, I do not work for Crowdsrike or Microsoft, if you find this helpful, consider following me. 
P.S: 
Current scripts available:
1. Delete_offending_file.bat: This is a script for LAN wake up enabled machines using RDP requires some deps; untested automated for mass machine revival.
2. Alternative_Del_Function.bat: requires assistance from hands on staff to wake machine in safe mode, automated file deletion in-mass once system is booted also untested.
3. Reboot_Solution.bat: Microsoft solution for systems, reboot 15 times. simple loop, should work but also untested.
