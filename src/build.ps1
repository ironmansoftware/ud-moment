$BuildFolder = $PSScriptRoot

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
	Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.Moment"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -ErrorAction SilentlyContinue -Recurse

New-Item -Path $OutputPath -ItemType Directory

npm install
npm run build

Copy-Item $BuildFolder\public\*.bundle.js $OutputPath
Copy-Item $BuildFolder\public\*.map $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.Moment.psm1 $OutputPath

$Version = "1.0.0"

$manifestParameters = @{
	Path = "$OutputPath\UniversalDashboard.Moment.psd1"
	Author = "Adam Driscoll"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2019 Ironman Software, LLC"
	RootModule = "UniversalDashboard.Moment.psm1"
	Description = "A time and date component for Universal Dashboard."
	ModuleVersion = $version
	Tags = @("universaldashboard", "moment", "ud-control", "time", "date")
	ReleaseNotes = "Initial release"
	FunctionsToExport = @(
		"New-UDMoment"
	)
	IconUri = "https://github.com/ironmansoftware/ud-moment/raw/master/images/logo.png"
	ProjectUri = "https://github.com/ironmansoftware/ud-moment"
  RequiredModules = @()
}

New-ModuleManifest @manifestParameters 

if ($prerelease -ne $null) {
	Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.Moment.psd1" -Prerelease $prerelease
}

