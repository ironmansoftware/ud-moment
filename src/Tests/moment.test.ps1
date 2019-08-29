Import-Module "$PSScriptRoot/../output/UniversalDashboard.Moment/UniversalDashboard.Moment.psd1"

$Dashboard = New-UDDashboard -Title "Moment Test" -Content {
    New-UDLayout -Columns 1 -Content {
        New-UDMoment -DateTime (Get-Date)
        New-UDMoment -DateTime (Get-Date) -Format "YYYY/MM/DD"
        New-UDMoment -DateTime (Get-Date).AddDays(-30) -FromNow
        New-UDMoment -DateTime (Get-Date).AddDays(-30) -From (Get-Date).AddDays(30)
        New-UDMoment -DateTime (Get-Date).AddDays(30) -ToNow
        New-UDMoment -DateTime (Get-Date).AddDays(30) -To (Get-Date).AddDays(-30)
        New-UDMoment -DateTime (Get-Date) -Duration (Get-Date).AddSeconds(10)
        New-UDMoment -DateTime (Get-Date).ToUniversalTime() -Local
        New-UDMoment -DateTime (Get-Date) -Locale 'en'
    }

}

Start-UDDashboard -Port 10000 -Dashboard $Dashboard -Force