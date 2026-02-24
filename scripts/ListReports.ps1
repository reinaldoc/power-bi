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

# $WorkspaceId = "00000000-1111-2222-3333-444444444444"
$WorkspaceId = Read-Host -Prompt "Enter Workspace ID"

$reports = Get-PowerBIReport -WorkspaceId $WorkspaceId

Write-Host "Reports:"

foreach($r in $reports.GetEnumerator()) {
    $id = $($r.Id)
    $name = $($r.Name)
    Write-Host ($id.ToString() + ":" + $name)
}

Read-Host "Pressione Enter para continuar"
