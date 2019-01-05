@echo off
rem --------------------------------------------------------------------------
rem This batch file uses nbconvert to automate the process of exporting
rem IPython Notebooks to html without inline CSS for my 
rem #100DaysOfCode project.
rem
rem Requires you also have the nocss.tpl nbconvert template I created
rem 
rem Script also renames exported filenames replacing spaces with _underscores
rem
rem Author: Jonathan Cutrer
rem License: MIT
rem --------------------------------------------------------------------------


rem First copy style.min.css from nbconvert module to the output dir,
rem The following command should get you the file path assuming that the 
rem nbconvert package is installed
rem where /R c:\ProgramData\Anaconda3\Lib\site-packages\nbconvert style.min.css

rem create _output directory if it does not exist
if exist _output (
    rem folder exists
    rem Cleanup previously exported html files
    del _output\*.html
) else (
    rem folder doesn't exist
    mkdir _output

)


rem create custom.css if it does not exist
if exist _output\custom.css (
    rem file exists, do nothing
) else (
    rem file doesn't exist
    echo "/** custom css **/" > _output\custom.css
)

rem Run nbconvert with a custom template (to exlude inline css) to export all notebooks as html
jupyter-nbconvert ..\*\*.ipynb --template=nocss --output-dir=_output

rem Replace all spaces with _underscores in all exported html filenames. 
cd _output

rem below was adopted from 
rem https://stackoverflow.com/questions/20791264/how-to-replace-all-spaces-by-underscores-in-all-file-names-of-a-folder
forfiles /m *.html /C "cmd /e:on /v:on /c set \"Phile=@file\" & if @ISDIR==FALSE ren @file !Phile: =_!"

cd ..