@echo off

echo %cd%
if not "%~dp0" == "%cd%" (
    cd "%~dp0"
)
echo I am currently in %cd%
