## Create Base Folder Structure
mkdir c:\Task
mkdir c:\Task\Fusion
mkdir c:\Task\API
mkdir c:\Task\Portal
mkdir c:\Task\Sales
mkdir c:\Task\XchangeNet

## Import WebAdmin Module
Import-Module WebAdministration

## Setup IIS Sites
New-Website -Name "Fusion" -Port 80 -IPAddress "*" -HostHeader "" -PhysicalPath "C:\Task\Fusion"
New-Website -Name "API" -Port 80 -IPAddress "*" -HostHeader "" -PhysicalPath "C:\Task\API"
New-Website -Name "Portal" -Port 80 -IPAddress "*" -HostHeader "" -PhysicalPath "C:\Task\Portal"

## Setup Devices App
New-Item -Type Application -Path "IIS:\Sites\Fusion\Devices" -PhysicalPath "C:\Task\XchangeNet"

## Change Default Web Page
Add-WebConfiguration //defaultDocument/files "IIS:\sites\Fusion" -atIndex 0 -Value @{value="XchangeFusion.html"}

## Configure Web App Pools
New-Item -Path "IIS:\AppPools" -Name "XchangeNet" -Type AppPool
Set-ItemProperty -Path "IIS:\AppPools\XchangeNet" -name "managedRuntimeVersion" -value "v4.0"
Set-ItemProperty -Path "IIS:\AppPools\XchangeNet" -name "enable32BitAppOnWin64" -value $true
Set-ItemProperty -Path "IIS:\AppPools\XchangeNet" -name "autoStart" -value $true
Set-ItemProperty -Path "IIS:\AppPools\XchangeNet" -name "processModel" -value @{identitytype="ApplicationPoolIdentity"}
Set-ItemProperty -Path "IIS:\AppPools\XchangeNet" -name "managedPipelineMode" -value 0
Set-ItemProperty -Path "IIS:\Sites\Fusion\Devices" -name "applicationPool" -value "XchangeNet"

New-Item -Path "IIS:\AppPools" -Name "Fusion" -Type AppPool
Set-ItemProperty -Path "IIS:\AppPools\Fusion" -name "managedRuntimeVersion" -value "v4.0"
Set-ItemProperty -Path "IIS:\AppPools\Fusion" -name "enable32BitAppOnWin64" -value $false
Set-ItemProperty -Path "IIS:\AppPools\Fusion" -name "autoStart" -value $true
Set-ItemProperty -Path "IIS:\AppPools\Fusion" -name "processModel" -value @{identitytype="ApplicationPoolIdentity"}
Set-ItemProperty -Path "IIS:\AppPools\Fusion" -name "managedPipelineMode" -value 0
Set-ItemProperty -Path "IIS:\Sites\Fusion" -name "applicationPool" -value "Fusion"

New-Item -Path "IIS:\AppPools" -Name "API" -Type AppPool
Set-ItemProperty -Path "IIS:\AppPools\API" -name "managedRuntimeVersion" -value "v4.0"
Set-ItemProperty -Path "IIS:\AppPools\API" -name "enable32BitAppOnWin64" -value $false
Set-ItemProperty -Path "IIS:\AppPools\API" -name "autoStart" -value $true
Set-ItemProperty -Path "IIS:\AppPools\API" -name "processModel" -value @{identitytype="ApplicationPoolIdentity"}
Set-ItemProperty -Path "IIS:\AppPools\API" -name "managedPipelineMode" -value 0
Set-ItemProperty -Path "IIS:\Sites\API" -name "applicationPool" -value "API"

New-Item -Path "IIS:\AppPools" -Name "Portal" -Type AppPool
Set-ItemProperty -Path "IIS:\AppPools\Portal" -name "managedRuntimeVersion" -value "v4.0"
Set-ItemProperty -Path "IIS:\AppPools\Portal" -name "enable32BitAppOnWin64" -value $false
Set-ItemProperty -Path "IIS:\AppPools\Portal" -name "autoStart" -value $true
Set-ItemProperty -Path "IIS:\AppPools\Portal" -name "processModel" -value @{identitytype="ApplicationPoolIdentity"}
Set-ItemProperty -Path "IIS:\AppPools\Portal" -name "managedPipelineMode" -value 0
Set-ItemProperty -Path "IIS:\Sites\Portal" -name "applicationPool" -value "Portal"
