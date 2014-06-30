﻿<#

.SYNOPSIS

Return properties of a give catalog identified by name, or all catalogs if no name is given.


.DESCRIPTION

Uses Get-BrokerCatalog from XenDesktop SDK, see 
http://support.citrix.com/proddocs/topic/citrix-broker-admin-v2-xd75/get-brokercatalog-xd75.html


.PARAMETER catalogName

Request results for a specific catalog. Optional


.PARAMETER log

log4net.ILog object used for logging calls. Optional, however the log4net.ILog type must be loaded
into the PowerShell RunSpace for this script to work.

Therefore, if you are running from a PowerShell, first call InitLog4net.ps1  This will load the 
necessary assemblies for the log4net.ILog type to resolve.

.PARAMETER ndcContext

GUID that cross references this logging message with those generated by thread to kicked off
the script.  Optional.


.NOTES
    Version:        1.0
    Author:			Donal Lafferty
    Creation Date:	2014-03-07
    Purpose/Change: CloudDestkop
 
You need to run this function as a user with admin access to XenDesktop

#>

Param (
    [string]$catalogName,
    [log4net.ILog]$log,
    [string]$ndcContext
)

$error.clear()

function LogDebug($msg) {
    if ($log){
        $log.Debug("$ndcContext $msg")
    } else {
        Write-Host($msg) 
    }
}
function LogInfo($msg) {
    if ($log){
        $log.Info("$ndcContext $msg")
    } else {
        Write-Host($msg) 
    }
}
function LogError($msg) {
    if ($log){
        $log.Error("$ndcContext $msg")
    } else {
        Write-Error($msg) 
    } 
}

$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
LogInfo("Current user is $user")

Add-pssnapin citrix.*


if ([string]::IsNullOrEmpty($catalogName))
{
    $catalogName = "*"
}
LogInfo("Query broker catalog details for $catalogName using Get-BrokerCatalog")
Get-BrokerCatalog -Name $catalogName
LogInfo("Query broker catalog complete") 
