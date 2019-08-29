
$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"
$Maps = Get-ChildItem "$PSScriptRoot\*.map"

$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($IndexJs.FullName)

foreach($item in $JsFiles)
{
    [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($item.FullName) | Out-Null
}

foreach($item in $Maps)
{
    [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($item.FullName) | Out-Null
}

function New-UDMoment {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory = $true)]
        [DateTime]$DateTime,
        [Parameter()]
        [string]$Format,
        [Parameter()]
        [switch]$FromNow,
        [Parameter()]
        [switch]$RemoveAgo,
        [Parameter()]
        [DateTime]$From,
        [Parameter()]
        [switch]$ToNow,
        [Parameter()]
        [DateTime]$To,
        [Parameter()]
        [DateTime]$Duration,
        [Parameter()]
        [Switch]$Local,
        [Parameter()]
        [string]$Locale
    )

    End {
        $Component = @{
            assetId = $AssetId 
            isPlugin = $true 
            type = "ud-moment"
            id = $Id
            title = $true
        }

        if ($null -ne $DateTime)
        {
            $Component["date"] = $DateTime.ToString("R")
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Format"))
        {
            $Component["format"] = $Format
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("FromNow"))
        {
            $Component["fromNow"] = $FromNow.IsPresent
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("RemoveAgo"))
        {
            $Component["ago"] = $RemoveAgo.IsPresent
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("From"))
        {
            $Component["from"] = $From.ToString("R")
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("ToNow"))
        {
            $Component["toNow"] = $ToNow.IsPresent
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("To"))
        {
            $Component["to"] = $To.ToString("R")
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Duration"))
        {
            $Component["duration"] = $Duration.ToString("R")
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Local"))
        {
            $Component["local"] = $Local.IsPresent
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Locale"))
        {
            $Component["locale"] = $Locale
        }

        $Component
    }
}