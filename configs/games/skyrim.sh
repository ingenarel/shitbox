#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

export WINEPREFIX="$HOME/.local/share/wineprefixes/skyrim"
export PROTONPATH="$HOME/.local/share/lutris/runners/proton/ge-proton"

installDotnet8(){
    wget\
        --directory-prefix=/tmp\
        "https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.410/dotnet-sdk-8.0.410-win-x64.exe"
    "$HOME/.local/share/lutris/runtime/umu/umu-run" "/tmp/dotnet-sdk-8.0.410-win-x64.exe"
}

setupRegEdits(){
    "$HOME/.local/share/lutris/runtime/umu/umu-run"\
        "$WINEPREFIX/drive_c/windows/regedit.exe"\
        "$scriptDir/skyrimSpecialEdition.reg"
}

[[ ! -d "$HOME/.local/share/wineprefixes/skyrim" ]]\
    &&
$HOME/.local/share/lutris/runtime/winetricks/winetricks\
    arch=64\
    prefix=skyrim\
    -q faudio vcrun2003 vcrun2005 vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2022


[[ ! -d "$WINEPREFIX/drive_c/Program Files/dotnet/metadata/workloads/8.0.400" ]] && installDotnet8

grep\
    -qEi\
    '\[Software\\\\Wow6432Node\\\\Bethesda Softworks\\\\Skyrim Special Edition\]'\
    "$WINEPREFIX/system.reg"\
    ||
setupRegEdits
