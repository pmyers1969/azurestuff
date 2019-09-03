#Provide the subscription Id of the subscription where managed disk exists
$sourceSubscriptionId='63320dda-7056-42db-b7d0-5661d65eb28c'

#Provide the name of your resource group where managed disk exists
$sourceResourceGroupName='SV-AZS-CORE-ASR-RG'

#Provide the name of the managed disk
$managedDiskName='sv-azs-asrtest_OsDisk_1_481f334f4e274424b6be0ada19deb166'

#Set the context to the subscription Id where Managed Disk exists
Select-AzureRmSubscription -SubscriptionId $sourceSubscriptionId

#Get the source managed disk
$managedDisk= Get-AzureRMDisk -ResourceGroupName $sourceResourceGroupName -DiskName $managedDiskName

#Provide the subscription Id of the subscription where managed disk will be copied to
#If managed disk is copied to the same subscription then you can skip this step
$targetSubscriptionId='f9244f81-9413-412b-a91e-508b4ed12bd0'

#Name of the resource group where snapshot will be copied to
$targetResourceGroupName='SV-AZS-WDT-TST-RG'

#Set the context to the subscription Id where managed disk will be copied to
#If snapshot is copied to the same subscription then you can skip this step
Select-AzureRmSubscription -SubscriptionId $targetSubscriptionId

$diskConfig = New-AzureRmDiskConfig -SourceResourceId $managedDisk.Id -Location $managedDisk.Location -CreateOption Copy 

#Create a new managed disk in the target subscription and resource group
New-AzureRmDisk -Disk $diskConfig -DiskName $managedDiskName -ResourceGroupName $targetResourceGroupName