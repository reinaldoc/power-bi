$WarningPreference = "SilentlyContinue"

Login-PowerBI

# Requires Admin permission to use scope Organization
$workspaces = Get-PowerBIWorkspace -Scope Organization -All

foreach($ws in $workspaces.GetEnumerator()) {
    $id = $($ws.Id)
    $name = $($ws.Name)
    if ($name -notlike "PersonalWorkspace*") {
        Write-Host ($id.ToString() + ":" + $name)
    }
}

Read-Host "Pressione Enter para continuar"
