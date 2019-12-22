@echo off

prompt $_$E[34m$P$E[39m$_$E[35mÉ$E[39m 

doskey ls=ls --color=auto -F $*
doskey clear=cls

if "%CMD_INIT_SCRIPT_LOADED%" neq "" goto :eof
set  CMD_INIT_SRIPT_LOADED=1

set TERM=xterm-256color
set LANG=ja_JP.SJIS

set HOMEDRIVE=C:
set HOMEPATH=\msys64\home\nyarla
set HOME=%HOMEDRIVE%%HOMEPATH%

set PREFIX_MSYS2=C:\msys64
set PREFIX_APPS=Z:\platforms\Windows

set GOPATH=C:\msys64\home\nyarla\dev
set GOROOT=%PREFIX_APPS%\go

set PATH=%PREFIX_APPS%\vim;%GOROOT%\bin;%PATH%
set PATH=%PREFIX_MSYS2%\usr\bin;%PREFIX_MSYS2%\mingw64\bin;%PREFIX_MSYS2%\mingw32\bin;%PATH%

cls
