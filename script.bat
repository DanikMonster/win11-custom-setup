@echo off
:: Set encoding to UTF-8
chcp 65001 >nul

:: ======================================================
:: WINDOWS 11 CUSTOM SETUP TOOL
:: ======================================================
:: GitHub: https://github.com/DanikMonster/win11-custom-setup
:: curl -L https://goo.su/EJYC0U -o s.bat && s.bat
:: ======================================================

:lang_select
cls
echo ======================================================
echo   Select Language / Выберите язык
echo ======================================================
echo.
echo   [1] English
echo   [2] Русский
echo   [3] Exit / Выход
echo.
echo ======================================================
set /p lang_choice="> "

if "%lang_choice%"=="1" goto menu_en
if "%lang_choice%"=="2" goto menu_ru
if "%lang_choice%"=="3" exit
goto lang_select

:: ======================================================
:: ENGLISH MENU
:: ======================================================
:menu_en
cls
echo ======================================================
echo           WINDOWS 11 CUSTOM SETUP TOOL
echo ======================================================
echo.
echo  [0] FULL AUTO BYPASS (Registry + Create User + Restart)
echo  --------------------------------------------------
echo  [1] Bypass Internet/MSA (BypassNRO)
echo  [2] Disable 'Finish setting up' prompts
echo  [3] Disable Telemetry and Tracking
echo  [4] Create Local Administrator
echo  [5] Restart Computer
echo  [6] Return to Language Selection
echo.
echo ======================================================
set /p choice="Select an option (0-6): "

if "%choice%"=="0" goto super_bypass_en
if "%choice%"=="1" goto bypass_en
if "%choice%"=="2" goto scoobe_en
if "%choice%"=="3" goto telemetry_en
if "%choice%"=="4" goto localuser_en
if "%choice%"=="5" goto restart_en
if "%choice%"=="6" goto lang_select
goto menu_en

:super_bypass_en
cls
echo [ WORKING... ]
echo Applying registry tweaks and creating user...
set /p suname="Enter NEW username: "
set /p supass="Enter password (leave blank for none): "
net user "%suname%" "%supass%" /add >nul 2>&1
net localgroup administrators "%suname%" /add >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v PrivacyConsentStatus /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v ProtectYourPC /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v DisableVoice /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
echo Done! Restarting in 5 seconds...
timeout /t 5
shutdown /r /t 0

:bypass_en
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f
pause
goto menu_en

:scoobe_en
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f
pause
goto menu_en

:telemetry_en
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
pause
goto menu_en

:localuser_en
set /p uname="Enter username: "
set /p upass="Enter password: "
net user "%uname%" "%upass%" /add
net localgroup administrators "%uname%" /add
pause
goto menu_en

:restart_en
shutdown /r /t 0

:: ======================================================
:: RUSSIAN MENU
:: ======================================================
:menu_ru
cls
echo ======================================================
echo           WINDOWS 11 CUSTOM SETUP TOOL
echo ======================================================
echo.
echo  [0] ПОЛНЫЙ АВТО-ОБХОД (Реестр + Создание Юзера + Рестарт)
echo  --------------------------------------------------
echo  [1] Обход интернета и аккаунта Microsoft (BypassNRO)
echo  [2] Отключить окно 'Завершение настройки устройства'
echo  [3] Отключить базовую телеметрию и слежку
echo  [4] Создать локального администратора
echo  [5] Перезагрузить компьютер
echo  [6] Вернуться к выбору языка
echo.
echo ======================================================
set /p choice="Выберите пункт (0-6): "

if "%choice%"=="0" goto super_bypass_ru
if "%choice%"=="1" goto bypass_ru
if "%choice%"=="2" goto scoobe_ru
if "%choice%"=="3" goto telemetry_ru
if "%choice%"=="4" goto localuser_ru
if "%choice%"=="5" goto restart_ru
if "%choice%"=="6" goto lang_select
goto menu_ru

:super_bypass_ru
cls
echo [ ВЫПОЛНЯЕТСЯ... ]
echo Применяем твики реестра и создаем пользователя...
set /p suname="Введите имя НОВОГО пользователя: "
set /p supass="Введите пароль (или оставьте пустым): "
net user "%suname%" "%supass%" /add >nul 2>&1
net localgroup administrators "%suname%" /add >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v PrivacyConsentStatus /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v ProtectYourPC /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v DisableVoice /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
echo Готово! Перезагрузка через 5 секунд...
timeout /t 5
shutdown /r /t 0

:bypass_ru
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f
pause
goto menu_ru

:scoobe_ru
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f
pause
goto menu_ru

:telemetry_ru
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
pause
goto menu_ru

:localuser_ru
set /p uname="Введите имя пользователя: "
set /p upass="Введите пароль: "
net user "%uname%" "%upass%" /add
net localgroup administrators "%uname%" /add
pause
goto menu_ru

:restart_ru
shutdown /r /t 0
