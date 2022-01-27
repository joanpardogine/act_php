@echo off

set fitxerAEnviar=%1

"C:\Program Files (x86)\WinSCP\WinSCP.com" ^
  /log="%RUTA%\WinSCP.log" /ini=nul ^
  /command ^
    "open ftp://joapar95:Jpc197frh@ftps3.us.freehostia.com/" ^
    "put %fitxerAEnviar%" ^
    "exit"

set WINSCP_RESULT=%ERRORLEVEL%

if %WINSCP_RESULT% equ 0 (
  echo Fitxer %fitxerAEnviar% enviat correctament!>%RUTA%\resultat.log
) else (
  echo Hi hagut un error al enviar el fitxer %fitxerAEnviar%!>%RUTA%\resultat.log
)

rem exit /b %WINSCP_RESULT%

