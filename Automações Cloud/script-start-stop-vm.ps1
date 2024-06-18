Param(
  [Parameter(Mandatory = $true)]
  [String]
  $TagName,
  [Parameter(Mandatory = $true)]
     
  [String]
  $TagValue,
  [Parameter(Mandatory = $true)]
  [Boolean]
  $Shutdown
)

Disable-AzContextAutosave -Scope Process

$AzureContext = (Connect-AzAccount -Identity).context

$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

  $vms = Get-AzResource -TagName $TagName -TagValue $TagValue | Where-Object -FilterScript {
    $_.ResourceType -like 'Microsoft.Compute/virtualMachines' 
  }

  Foreach ($vm in $vms) 
  {
    if ($Shutdown -eq $true) 
    {
      Write-Output -InputObject "Stopping $($vm.Name)"        
      Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName -Force
    }
    else 
    {
      Write-Output -InputObject "Starting $($vm.Name)"        
      Start-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
    }
  }