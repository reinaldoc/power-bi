$WarningPreference = "SilentlyContinue"

Login-PowerBI

# $WorkspaceId = "00000000-1111-2222-3333-444444444444"
$WorkspaceId = Read-Host -Prompt "Enter Workspace ID: "

$semanticmodels = Get-PowerBIReport -WorkspaceId $WorkspaceId

foreach($sm in $semanticmodels.GetEnumerator()) {
    $id = $($sm.Id)
    $name = $($sm.Name)
    Write-Host ($id.ToString() + ":" + $name)
}

Read-Host "Pressione Enter para continuar"
