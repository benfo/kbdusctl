$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/benfo/kbdusctl/releases/download/v1.0/kbdusctl.zip'
$url64 = 'https://github.com/benfo/kbdusctl/releases/download/v1.0/kbdusctl.zip'
$file = Join-Path $toolsDir 'kbdusctl_i386.msi'
$file64 = Join-Path $toolsDir 'kbdusctl_amd64.msi'

$zipPackageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $toolsDir
    url            = $url
    url64bit       = $url64
    checksum       = 'A5E03DAB59F72B59C56BC41B452AF7A5'
    checksumType   = 'md5'
    checksum64     = 'A5E03DAB59F72B59C56BC41B452AF7A5'
    checksumType64 = 'md5'
}
Install-ChocolateyZipPackage @zipPackageArgs

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'MSI'
    file           = $file
    file64         = $file64
    softwareName   = 'United States-International (Ctrl dead keys)*'
    silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
    validExitCodes = @(0, 3010, 1641)
}
Install-ChocolateyInstallPackage @packageArgs