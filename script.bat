@echo off
:: This is a wrapper to launch the reliable PowerShell version of the tool
powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/DanikMonster/win11-custom-setup/main/setup.ps1 | iex"
