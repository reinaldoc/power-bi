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

Write-Host ("My Tenant ID: " + $login.TenantId)
Read-Host "Pressione Enter para continuar"
