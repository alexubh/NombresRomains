@echo off

rem Récupérer les paramètres
set refname=%1
set oldrev=%2
set newrev=%3

rem Vérifier si les paramètres sont présents
if "%refname%"=="" goto :error
if "%oldrev%"=="" goto :error
if "%newrev%"=="" goto :error

rem Configurations
setlocal enabledelayedexpansion
set allowunannotated=true
set allowdeletebranch=true
set denycreatebranch=true
set allowdeletetag=true
set allowmodifytag=true

rem Vérifier la description du projet
rem set projectdesc=
rem set /P projectdesc=<.git\description
rem if "%projectdesc%"=="Unnamed repository" (
rem     echo *** Le fichier de description du projet n'a pas été configuré correctement. >&2
rem     exit /b 1
rem )

rem Vérifier le type de mise à jour
set zero=0000000000000000000000000000000000000000
if "%newrev%"=="%zero%" (
    set newrev_type=delete
) else (
    for /f %%h in ('git cat-file -t %newrev%') do set "newrev_type=%%h"
)

rem Vérifications en fonction du type de mise à jour
if "%newrev_type%,%refname%"=="commit,refs/heads/main" (
    rem Ajoutez vos vérifications spécifiques ici

    rem Exécutez votre script de workflow avec le numéro de commit
    call C:\Code\Python\NombresRomains\Scripts\workflow.cmd %newrev%
) else (
    echo *** Type de mise à jour inconnu pour %refname% avec newrev_type=%newrev_type% >&2
    exit /b 1
)

rem Fin du script
exit /b 0

:error
echo Usage: %0 ^<ref^> ^<oldrev^> ^<newrev^> >&2
exit /b 1