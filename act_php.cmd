@echo off

title Control SXA
color 17

cls

set CAMI=%~dp0%Logs\
set DIA=%date:~0,2%
set MES=%date:~3,2%
set ANY=%date:~6,4%

For /f "tokens=1-3 delims=1234567890 " %%a in ("%time%") Do set "delims=%%a%%b%%c"

For /f "tokens=1-4 delims=%delims%" %%G in ("%time%") Do (
    Set _HH=%%G
    Set _MM=%%H
    Set _SS=%%I
    Set _MS=%%J
  )

:: Strip any leading spaces
  Set _HH=%_HH: =%

  :: Ensure the hours have a leading zero
  if 1%_HH% LSS 20 Set _HH=0%_HH%

set DATAEXECUCIO=%ANY%%MES%%DIA%_%_HH%%_MM%%_SS%
echo Entrada de dades
echo ================
set /p NOM=Entra nomes el teu nom: 
set /p COGNOM=Entra nomes el teu cognom: 


cls

echo.
echo Obtenint dades...
echo.

set NOMALUMNE=%COGNOM:~0,2%%NOM:~0,2%

set RUTAFITXERLOG=%CAMI%%NOMALUMNE%_PHP\

set FITXER_LOG=%RUTAFITXERLOG%%NOMALUMNE%_%DATAEXECUCIO%_log.smx2


del /q %CAMI%*.* >%FITXER_LOG%


 For %%G in ("%RUTAFITXERLOG%") DO set _isdir=%%~aG >>%FITXER_LOG%


set _siesdir=%_isdir:~0,1%


If /I "%_siesdir%" NEQ "d" ( mkdir %RUTAFITXERLOG%  >>%FITXER_LOG% )


:: del /q %RUTAFITXERLOG%   >>%FITXER_LOG%

copy C:\PHP\php.ini %RUTAFITXERLOG%php_ini.smx2 >>%FITXER_LOG%

copy C:\inetpub\wwwroot\test.php* %RUTAFITXERLOG%test_php.smx2 >>%FITXER_LOG%

echo %PATH% %RUTAFITXERLOG%path.smx2 > nul

php -info > %RUTAFITXERLOG%php_info.smx2 > nul

7z a -tzip %RUTAFITXERLOG%%NOMALUMNE%_%DATAEXECUCIO%.zip %RUTAFITXERLOG%*.* -x!*.zip > nul

echo.
echo Enviant dades...
echo.

call %RUTA%\pujarAmbWinscp.cmd %RUTAFITXERLOG%%NOMALUMNE%_%DATAEXECUCIO%.zip > nul

type %RUTA%\resultat.log

echo.
echo.
echo Proces finalitzat, si us plau, pitja una tecla per acabar!
echo.
echo.
pause >nul

color

exit
