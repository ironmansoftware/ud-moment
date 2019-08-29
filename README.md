# UDMoment

![](./images/logo.png)

Time and Date component for Universal Dashboard. 

## Installation

```
Install-Module UniversalDashboard.Moment 
```

## Examples

### Outputing a date and time

```
New-UDMoment -DateTime (Get-Date)

Outputs: Thu Aug 29 2019 09:40:16 GMT-0600
```

### Formatting date and time

```
New-UDMoment -DateTime (Get-Date) -Format "YYYY/MM/DD"

Outputs: 2019/08/29
```

### Date and time from now

```
New-UDMoment -DateTime (Get-Date).AddDays(-30) -FromNow

Outputs: a month ago
```

### Date and time from one date to another

```
New-UDMoment -DateTime (Get-Date).AddDays(-30) -From (Get-Date).AddDays(30)

Outputs: 2 months ago
```

### Date and time to now

```
New-UDMoment -DateTime (Get-Date).AddDays(30) -ToNow

Outputs: a month ago
```

### Date and time to one date to another

```
New-UDMoment -DateTime (Get-Date).AddDays(30) -To (Get-Date).AddDays(-30)

Outputs: 2 months ago
```

### Duration between two dates

```
New-UDMoment -DateTime (Get-Date) -Duration (Get-Date).AddSeconds(10)

Outputs: -0:10
```

### Convert UTC to local time

```
New-UDMoment -DateTime (Get-Date).ToUniversalTime() -Local

Outputs: Thu Aug 29 2019 15:40:16 GMT-0600
```

### Selecting locale 

_Note: Locales are not loaded dynamically at the moment (heh.). That will need to be added to fully support this feature_

```
New-UDMoment -DateTime (Get-Date) -Locale 'en'

Outputs: Thu Aug 29 2019 09:40:16 GMT-0600
```