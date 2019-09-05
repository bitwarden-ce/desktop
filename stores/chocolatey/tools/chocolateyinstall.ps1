$ErrorActionPreference = 'Stop';

$url = 'https://github.com/bytegarden/desktop/releases/download/v__version__/Bitwarden-Installer-__version__.exe'
$checksum = '__checksum__'

$packageArgs = @{
  packageName   = 'bytegarden'
  fileType      = 'EXE'
  softwareName  = 'Bitwarden'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
