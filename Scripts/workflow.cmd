@echo off
setlocal

rem Variables
set repositoryLocalPath=C:\Code\Python\NombresRomains
set tmpFolderBase=C:\Code\Python\tmp
set testScriptPath=C:\Code\Python\NombresRomains\test\test.py
set githubRepository=https://github.com/alexubh/NombresRomains.git
set mainBranch=main
set devBranch=dev
set email=alexandre.ubach@ecoles-epsi.net
set username=alexubh

rem Récupère le premier paramètre et le stocke dans une variable
set commitNumber=d646daa9303c0d09d62b11dd5635642623d95be4
rem set commitNumber=%1

rem Vérifier que la variable commitNumber n'est pas vide
if not defined commitNumber (
    echo Erreur : Aucun numéro de commit n'a été fourni.
    exit /b 1
)

rem Set le n°commit manuellement
rem set commitNumber=419ac15a8af3aedc05c2b090abf44096ca9737d0

rem Cré un répertoire temporaire unique
set tmpFolderPath=%tmpFolderBase%\tmp_%commitNumber%
if not exist %tmpFolderPath% (
    mkdir %tmpFolderPath%
)

rem Configuration de Git
git config --global user.email "%email%"
git config --global user.name "%username%"

rem Fait un clone vers le répertoire temporaire unique
git clone %githubRepository% %tmpFolderPath%
cd %tmpFolderPath%

rem Fait un git checkout sur le numéro de commit
git checkout %commitNumber%

rem Exécute les tests unitaires
python %testScriptPath%

rem Si le résultat du test est OK, fait un fast forward de la branche master sur le commit
if %errorlevel% equ 0 (
	git checkout %mainBranch%
	git merge --ff-only %commitNumber%
	git push origin %mainBranch%
) else (
    rem Si le résultat n'est pas bon, crée une branche « failed_horodatage » et recule le commit de la branche dev juste avant
    set datetime=%date:~10,4%%date:~7,2%%date:~4,2%_%time:~0,2%%time:~3,2%%time:~6,2%
    git checkout -b failed_%datetime%
    git checkout %devBranch%
    git reset --hard HEAD^
    git push origin %failedBranch%
)

cd %repositoryLocalPath%
rmdir /s /q %tmpFolderPath%

endlocal