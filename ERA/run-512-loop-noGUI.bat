@ECHO OFF
set app=erachain
set xms=512
set xmx=1024
set pars=-nogui

:start

IF EXIST java (
	::start "%app%" java -Xms%xms%m -jar %app%.jar %pars%
	java -Xms%xms%m -jar %app%.jar %pars%
	if %ERRORLEVEL% == 0 GOTO end
	goto continue
)

REG QUERY "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\1.7" /v "JavaHome" >nul 2>nul || ( GOTO NOTFOUND1 )
	for /f "tokens=1,2,*" %%a in ('reg query "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\1.7" /v "JavaHome"') do if "%%a"=="JavaHome" set JAVAHOME=%%c

IF EXIST "%JAVAHOME%\bin\java.exe" (
	::start "%app%" "%JAVAHOME%\bin\java.exe" -Xms%xms%m -jar %app%.jar %pars%
	"%JAVAHOME%\bin\java.exe" -Xms%xms%m -jar %app%.jar %pars%
	if %ERRORLEVEL% == 0 GOTO end
	goto continue
	EXIT /b
)

:NOTFOUND1

REG QUERY "HKLM\SOFTWARE\WOW6432NODE\JavaSoft\Java Runtime Environment\1.7" /v "JavaHome" >nul 2>nul || ( GOTO NOTFOUND2 )
	for /f "tokens=1,2,*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432NODE\JavaSoft\Java Runtime Environment\1.7" /v "JavaHome"') do if "%%a"=="JavaHome" set JAVAHOME=%%c

IF EXIST "%JAVAHOME%\bin\java.exe" (
	::start "%app%" "%JAVAHOME%\bin\java.exe" -Xms%xms%m -jar %app%.jar %pars%
	"%JAVAHOME%\bin\java.exe" -Xms%xms%m -jar %app%.jar %pars%
	if %ERRORLEVEL% == 0 GOTO end
	goto continue
	EXIT /b
)

:NOTFOUND2

REG QUERY "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\1.8" /v "JavaHome" >nul 2>nul || ( GOTO NOTFOUND3 )
	for /f "tokens=1,2,*" %%a in ('reg query "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\1.8" /v "JavaHome"') do if "%%a"=="JavaHome" set JAVAHOME=%%c
	
IF EXIST "%JAVAHOME%\bin\java.exe" (
	::start "%app%" "%JAVAHOME%\bin\java.exe" -Xms%xms%m -jar %app%.jar %pars%
	"%JAVAHOME%\bin\java.exe" -Xms%xms%m -jar %app%.jar %pars%
	if %ERRORLEVEL% == 0 GOTO end
	goto continue
	EXIT /b
)

:NOTFOUND3

REG QUERY "HKLM\SOFTWARE\WOW6432NODE\JavaSoft\Java Runtime Environment\1.8" /v "JavaHome" >nul 2>nul || ( GOTO NOTFOUND4 )
	for /f "tokens=1,2,*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432NODE\JavaSoft\Java Runtime Environment\1.8" /v "JavaHome"') do if "%%a"=="JavaHome" set JAVAHOME=%%c

IF EXIST "%JAVAHOME%\bin\java.exe" (
	::start "%app%" "%JAVAHOME%\bin\java.exe" -Xms%xms%m -jar %app%.jar %pars%
	"%JAVAHOME%\bin\java.exe" -Xms%xms%m -jar %app%.jar %pars%
	if %ERRORLEVEL% == 0 GOTO end
	goto continue
	EXIT /b
)


:continue

timeout /t 20
goto start

	
:NOTFOUND4

ECHO Java software not found on your system. Please go to http://java.com to download a copy of Java.
PAUSE

goto end

:continue

timeout /t 30
goto start

:end