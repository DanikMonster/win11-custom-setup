$ErrorActionPreference = "SilentlyContinue"

function Show-Menu {
    Clear-Host
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host "         WINDOWS 11 CUSTOM SETUP TOOL (PS)" -ForegroundColor Cyan
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [1] English"
    Write-Host "  [2] Русский"
    Write-Host "  [3] Exit / Выход"
    Write-Host ""
    $lang = Read-Host "> Select Language"
    return $lang
}

function Main-Menu-EN {
    Clear-Host
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host "           WINDOWS 11 CUSTOM SETUP TOOL" -ForegroundColor Cyan
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [0] FULL AUTO BYPASS (Registry + Create User + Restart)" -ForegroundColor Yellow
    Write-Host "  --------------------------------------------------"
    Write-Host "  [1] Bypass Internet/MSA (BypassNRO)"
    Write-Host "  [2] Disable 'Finish setting up' prompts"
    Write-Host "  [3] Disable Telemetry and Tracking"
    Write-Host "  [4] Create Local Administrator"
    Write-Host "  [5] Restart Computer"
    Write-Host "  [6] Exit"
    Write-Host ""
    $choice = Read-Host "Select an option (0-6)"
    return $choice
}

function Main-Menu-RU {
    Clear-Host
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host "           WINDOWS 11 CUSTOM SETUP TOOL" -ForegroundColor Cyan
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [0] ПОЛНЫЙ АВТО-ОБХОД (Реестр + Создание Юзера + Рестарт)" -ForegroundColor Yellow
    Write-Host "  --------------------------------------------------"
    Write-Host "  [1] Обход интернета и аккаунта Microsoft (BypassNRO)"
    Write-Host "  [2] Отключить окно 'Завершение настройки устройства'"
    Write-Host "  [3] Отключить базовую телеметрию и слежку"
    Write-Host "  [4] Создать локального администратора"
    Write-Host "  [5] Перезагрузить компьютер"
    Write-Host "  [6] Выход"
    Write-Host ""
    $choice = Read-Host "Выберите пункт (0-6)"
    return $choice
}

# --- Actions ---

function Apply-Bypass {
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v PrivacyConsentStatus /t REG_DWORD /d 1 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v ProtectYourPC /t REG_DWORD /d 3 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v DisableVoice /t REG_DWORD /d 1 /f
}

function Disable-Prompts {
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f
}

function Disable-Telemetry {
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
}

function Create-User {
    param($u, $p)
    net user "$u" "$p" /add
    net localgroup administrators "$u" /add
}

# --- Execution Logic ---

$lang = Show-Menu
if ($lang -eq "3") { exit }

while ($true) {
    if ($lang -eq "2") { $c = Main-Menu-RU } else { $c = Main-Menu-EN }
    
    switch ($c) {
        "0" {
            $u = Read-Host "Username / Имя пользователя"
            $p = Read-Host "Password / Пароль (Enter for empty)"
            Create-User $u $p
            Apply-Bypass
            Disable-Prompts
            Disable-Telemetry
            Write-Host "Done! Restarting..." -ForegroundColor Green
            Start-Sleep -Seconds 3
            Restart-Computer -Force
        }
        "1" { Apply-Bypass; Read-Host "Done! Press Enter" }
        "2" { Disable-Prompts; Read-Host "Done! Press Enter" }
        "3" { Disable-Telemetry; Read-Host "Done! Press Enter" }
        "4" {
            $u = Read-Host "Username / Имя пользователя"
            $p = Read-Host "Password / Пароль"
            Create-User $u $p
            Read-Host "Done! Press Enter"
        }
        "5" { Restart-Computer -Force }
        "6" { exit }
    }
}
