@echo off
:: Set encoding to UTF-8
chcp 65001 >nul

:: ======================================================
:: WINDOWS 11 CUSTOM SETUP TOOL
:: ======================================================
:: GitHub: https://github.com/DanikMonster/win11-custom-setup
:: Запуск одной командой (через Shift+F10):
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

if "%lang_choice%"=="1" goto set_en
if "%lang_choice%"=="2" goto set_ru
if "%lang_choice%"=="3" exit
goto lang_select

:set_en
set "m_title=WINDOWS 11 CUSTOM SETUP TOOL"
set "m_opt0=[0] FULL AUTO BYPASS (Registry + Create User + Restart)"
set "m_opt1=[1] Bypass Internet/MSA (BypassNRO)"
set "m_opt2=[2] Disable 'Finish setting up' prompts"
set "m_opt3=[3] Disable Telemetry and Tracking"
set "m_opt4=[4] Create Local Administrator"
set "m_opt5=[5] Restart Computer"
set "m_opt6=[6] Exit to Language Selection"
set "m_select=Select an option (0-6): "
set "m_working=WORKING..."
set "m_done=Done! Press any key to return to menu."
set "m_restart_msg=The computer will restart in 5 seconds..."
set "m_user_name=Enter NEW username: "
set "m_user_pass=Enter password (leave blank for none): "
set "m_user_done=User created and added to Administrators."
set "m_super_info=Applying registry tweaks and creating user..."
goto menu

:set_ru
set "m_title=WINDOWS 11 CUSTOM SETUP TOOL"
set "m_opt0=[0] ПОЛНЫЙ АВТО-ОБХОД (Реестр + Создание Юзера + Рестарт)"
set "m_opt1=[1] Обход интернета и аккаунта Microsoft (BypassNRO)"
set "m_opt2=[2] Отключить окно 'Завершение настройки устройства'"
set "m_opt3=[3] Отключить базовую телеметрию и слежку"
set "m_opt4=[4] Создать локального администратора"
set "m_opt5=[5] Перезагрузить компьютер"
set "m_opt6=[6] Вернуться к выбору языка"
set "m_select=Выберите пункт (0-6): "
set "m_working=ВЫПОЛНЯЕТСЯ..."
set "m_done=Готово! Нажмите любую клавишу для возврата в меню."
set "m_restart_msg=Компьютер будет перезагружен через 5 секунд..."
set "m_user_name=Введите имя НОВОГО пользователя: "
set "m_user_pass=Введите пароль (или оставьте пустым): "
set "m_user_done=Пользователь создан и добавлен в группу Администраторы."
set "m_super_info=Применяем твики реестра и создаем пользователя..."
goto menu

:menu
cls
echo ======================================================
echo           %m_title%
echo ======================================================
echo.
echo  %m_opt0%
echo  --------------------------------------------------
echo  %m_opt1%
echo  %m_opt2%
echo  %m_opt3%
echo  %m_opt4%
echo  %m_opt5%
echo  %m_opt6%
echo.
echo ======================================================
set /p choice="%m_select%"

if "%choice%"=="0" goto super_bypass
if "%choice%"=="1" goto bypass
if "%choice%"=="2" goto scoobe
if "%choice%"=="3" goto telemetry
if "%choice%"=="4" goto localuser
if "%choice%"=="5" goto restart
if "%choice%"=="6" goto lang_select
goto menu

:super_bypass
cls
echo [ %m_working% ]
echo.
echo %m_super_info%
echo.
set /p suname="%m_user_name%"
set /p supass="%m_user_pass%"

:: Create User
net user "%suname%" "%supass%" /add >nul 2>&1
net localgroup administrators "%suname%" /add >nul 2>&1

:: Registry Tweaks
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v PrivacyConsentStatus /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v ProtectYourPC /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v DisableVoice /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

echo.
echo %m_user_done%
echo %m_restart_msg%
timeout /t 5
shutdown /r /t 0

:bypass
cls
echo [ %m_working% ]
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f
echo.
echo %m_done%
pause
goto menu

:scoobe
cls
echo [ %m_working% ]
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f
echo.
echo %m_done%
pause
goto menu

:telemetry
cls
echo [ %m_working% ]
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
echo.
echo %m_done%
pause
goto menu

:localuser
cls
echo [ %m_working% ]
echo.
set /p uname="%m_user_name%"
set /p upass="%m_user_pass%"
net user "%uname%" "%upass%" /add
net localgroup administrators "%uname%" /add
echo.
echo %m_user_done%
pause
goto menu

:restart
cls
echo %m_restart_msg%
timeout /t 5
shutdown /r /t 0
