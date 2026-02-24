$WarningPreference = "SilentlyContinue"
$ErrorActionPreference = "Stop"

Write-Host "Iniciando Login..."
try {
    $login = Login-PowerBI
    Write-Host ("Usuário " + $login.UserName + " autenticado com sucesso.")
} catch {
    Write-Host "Login falhou"
    Read-Host "Pressione Enter para sair"
    exit
}

# Requires Admin permission to use scope Organization
$workspaces = Get-PowerBIWorkspace -Scope Organization -All

Write-Host ("Workspaces for tenant: " + $login.TenantId)

foreach($ws in $workspaces.GetEnumerator()) {
    $id = $($ws.Id)
    $name = $($ws.Name)
    if ($name -notlike "PersonalWorkspace*") {
        Write-Host ($id.ToString() + ":" + $name)
    }
}

Read-Host "Pressione Enter para continuar"
