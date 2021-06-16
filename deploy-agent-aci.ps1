# Deploy to North Europe
#Select-AzSubscription hsbc-multi-shrd-01
param ( 
    [Parameter(Mandatory)]$subName,
    [Parameter(Mandatory)]$rgName,
    [Parameter(Mandatory)]$containerName,
    [Parameter(Mandatory)]$imageName,
    [Parameter(Mandatory)]$acrusr,
    [Parameter(Mandatory)]$acrpw,
    [Parameter(Mandatory)]$AZP_AGENT_NAME,
    [Parameter(Mandatory)]$AZP_POOL,
    [Parameter(Mandatory)]$AZP_URL,
    [Parameter(Mandatory)]$AZP_TOKEN,
    [Parameter(Mandatory)]$location,
    [Parameter(Mandatory)]$vnet,
    $OSType = "Linux",
    $DEPLOY = "blue",
    $NoOfinstances = 1,
    $networkProfile = 'networkProfile1',
    $recreate = $false
)


$password = ConvertTo-SecureString $env:ARMCLIENTSECRET -AsPlainText -Force
$pscredential = New-Object -TypeName System.Management.Automation.PSCredential($env:ARMCLIENTID , $password)
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $env:TENANTID

Select-AzSubscription $subName

1..$NoOfinstances | %{

    $containerNameinstance = $containerName + "-" + "$DEPLOY" + "-" + $_

    if($recreate -eq "TRUE") {
        $checkifexists = get-AzContainerGroup -ResourceGroupName $rgName -Name $containerNameinstance -ErrorAction SilentlyContinue
        if ($checkifexists) {
            write-host "Container exists - delete existing container instances "
            $checkifexists

            Remove-AzContainerGroup -ResourceGroupName $rgName -Name $containerNameinstance -Confirm:$false

        }
        
    }

    #$secpasswd = ConvertTo-SecureString $acrpw -AsPlainText -Force
    #$creds = New-Object System.Management.Automation.PSCredential ($acrusr, $secpasswd)

    $AZP_AGENT_NAME = $containerNameinstance

    $checkifexists = get-AzContainerGroup -ResourceGroupName $rgName -Name $containerNameinstance -ErrorAction SilentlyContinue


    if($checkifexists) { 
         # Restart if exists
         #Invoke-AzResourceAction -ResourceId $checkifexists.Id -Action restart -Force
        write-host "Container instance exists - restart the container to refresh the image"
        $checkifexists
        Write-host "Existing Managed ID = $containerNameinstance = $($checkifexists.Identity.PrincipalId)"
        Invoke-AzResourceAction -ResourceId $checkifexists.Id -Action restart -Force
    
    }

    <#
    New-AzContainerGroup -ResourceGroupName $rgName `
                        -Location $location `
                        -Name $containerNameinstance `
                        -Image $imageName `
                        -OSType $OSType `
                        -RegistryCredential $creds `
                        -IdentityType "SystemAssigned" `
                        -EnvironmentVariable @{"AZP_URL"="$AZP_URL";"AZP_TOKEN"=$AZP_TOKEN;"AZP_AGENT_NAME"=$AZP_AGENT_NAME;"AZP_POOL"=$AZP_POOL;"DEPLOY"="$DEPLOY"}
    #>
    
    az login --service-principal --username $env:ARMCLIENTID --password $env:ARMCLIENTSECRET --tenant $env:TENANTID
    
    az account set -s $subName
    
    az container create --resource-group $rgName `
                        --name $containerNameinstance `
                        --image $imageName `
                        --os-type $OSType `
                        --registry-username $acrusr `
                        --registry-password $acrpw `
                        --environment-variables AZP_URL=$AZP_URL AZP_TOKEN=$AZP_TOKEN AZP_AGENT_NAME=$AZP_AGENT_NAME AZP_POOL=$AZP_POOL DEPLOY=$DEPLOY 

    #                    --network-profile $networkProfile #  not supported on Windows container. 


    $checkifexists = get-AzContainerGroup -ResourceGroupName $rgName -Name $containerNameinstance -ErrorAction SilentlyContinue
    $checkifexists
    Write-host "Current Managed ID $containerNameinstance = $($checkifexists.Identity.PrincipalId)"
}
