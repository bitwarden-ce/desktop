﻿param (
    [string] $version,
    [switch] $mas
)

# Dependencies:
# 1. brew cask install powershell
#
# To run:
# pwsh ./build-safari-appex.ps1 -version 1.41.0

$dir = Split-Path -Parent $MyInvocation.MyCommand.Path;
$rootDir = $dir + "\..";
$distDir = $rootDir + "\dist";
$distSafariDir = $distDir + "\safari";
$distSafariAppexDmg = $distSafariDir + "\browser\dist\Safari\dmg\build\Release\safari.appex";
$distSafariAppexMas = $distSafariDir + "\browser\dist\Safari\mas\build\Release\safari.appex";
$pluginsAppex = $rootDir + "\PlugIns\safari.appex";

if(Test-Path -Path $distSafariDir) {
  Remove-Item -Recurse -Force $distSafariDir
}

if(Test-Path -Path $pluginsAppex) {
  Remove-Item -Recurse -Force $pluginsAppex
}

New-Item $distSafariDir -ItemType Directory -ea 0
cd $distSafariDir
git clone git@github.com:bytegarden/browser.git
cd browser

if(-not ([string]::IsNullOrEmpty($version))) {
  $tag = "v" + $version
  git checkout tags/$tag
}

npm i
npm run dist:safari
if($mas) {
  Copy-Item -Path $distSafariAppexMas -Destination $pluginsAppex –Recurse
} else {
  Copy-Item -Path $distSafariAppexDmg -Destination $pluginsAppex –Recurse
}
cd $rootDir
