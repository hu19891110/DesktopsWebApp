﻿<#

.SYNOPSIS

Sends request for change of powerstate to XenDesktop broker service.


.DESCRIPTION

Uses Get-BrokerMachine from XenDesktop SDK, see http://support.citrix.com/proddocs/topic/citrix-broker-admin-v2-xd75/remove-brokermachine-xd75.html


.PARAMETER ddcAddress

FQDN and port for DDC, e.g. "xdc1.clouddesktop.cambourne.cloud.com:80"


.PARAMETER machineName

Active Directory machine name for machine to be sent a power action.  E.g. 'TENANT3\JuneTestA001'


.PARAMETER powerAction

Specifies the power state change action that is to be performed on the specified machine.

Valid values are: TurnOn, TurnOff, ShutDown, Reset, Restart, Suspend and Resume.


.PARAMETER log

log4net.ILog object used for logging calls. Optional, however the log4net.ILog type must be loaded
into the PowerShell RunSpace for this script to work.

Therefore, if you are running from a PowerShell, first call InitLog4net.ps1  This will load the 
necessary assemblies for the log4net.ILog type to resolve.


.PARAMETER ndcContext

GUID that cross references this logging message with those generated by thread to kicked off
the script.  Optional.



.NOTES
    (c)opyright Citrix Systems
    Version:        1.0
    Author:			Donal Lafferty
    Creation Date:	2014-03-07
    Purpose/Change: CloudDestkop
 
You need to run this function as a user with admin access to XenDesktop

#>

Param (
    [string]$ddcAddress,
    [string]$machineName,
    [string]$powerAction,
    [log4net.ILog]$log,
    [string]$ndcContext
)

Add-pssnapin citrix.*

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


# Docs http://support.citrix.com/proddocs/topic/citrix-broker-admin-v2-xd75/new-brokerhostingpoweraction-xd75.html
LogInfo ("New-BrokerHostingPowerAction -Action $machineName -AdminAddress $ddcAddress -MachineName $machineName")
New-BrokerHostingPowerAction -Action $machineName -AdminAddress $ddcAddress -MachineName $machineName
LogInfo ("Requested new power state for $machineName of $powerAction (using New-BrokerHostingPowerAction)")
