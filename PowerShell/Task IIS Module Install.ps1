## Import the Server Manager Module
Import-Module servermanager

## Install Required IIS Modules
Install-WindowsFeature -Name Web-Server,Web-Default-Doc,Web-Dir-Browsing,Web-Http-Errors,Web-Static-Content,Web-Http-Logging,Web-Stat-Compression,Web-Filtering,Web-Net-Ext,Web-Net-Ext45,Web-AppInit,Web-ASP,Web-Asp-Net,Web-Asp-Net45,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Includes,Web-WebSockets,Web-Mgmt-Console,Web-Mgmt-Compat,Web-Metabase -Source E:\Sources\SxS