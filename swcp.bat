::
:: Switch code page between 65001(UTF-8) and 936(GBK),
:: If neither, then do nothing.
::
@echo off
SETLOCAL

@set cpGBK=936
@set cpUTF8=65001

:: Test code page 936:
::
:: If the current code page is 936,
:: command `chcp` will output "活动代码页: 936",
:: which will be treated as 2 tokens by command FOR.
:: Extract the last token, compare with 936.
::
@for /F "usebackq tokens=2" %%a in (`chcp`) do set cp=%%a
@if %cp%==%cpGBK% (
	call :change %cpUTF8% UTF-8
	goto end
)

:: Test code page 65001:
::
:: If the current code page is 65001, 
:: command 'chcp' will output "Active code page: 65001",
:: which will be treated as 4 tokens by command FOR.
:: Extract the last token, compare with 65001.
::
@for /F "usebackq tokens=4" %%a in (`chcp`) do set cp=%%a
@if %cp%==%cpUTF8% (
	call :change %cpGBK% GBK
	goto end
)

:: Neither, do nothing
@goto end

:: @function
:: change code page and print
:: @param %~1 - code page number
:: @param %~2 - code page name
:change
@chcp %~1 > nul
@echo Code Page: %~1 %~2
goto:eof

:end
ENDLOCAL
@echo on
