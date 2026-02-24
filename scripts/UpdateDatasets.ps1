$WarningPreference = "SilentlyContinue"

Write-Host "Iniciando Login..."
Login-PowerBI

$WorkspaceId = "00000000-1111-2222-3333-444444444444"

$DatasetId   = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
Write-Host "Iniciando atualização do Painel 1..."
Invoke-PowerBIRestMethod -Url "groups/$WorkspaceId/datasets/$DatasetId/refreshes" -Method Post -Body "{}"
Write-Host "Aguardando 10 segundos..."
Start-Sleep -Seconds 10

$DatasetId   = "zzzzzzzz-xxxx-wwww-yyyy-vvvvvvvvvvvv"
Write-Host "Iniciando atualização do Painel 2..."
Invoke-PowerBIRestMethod -Url "groups/$WorkspaceId/datasets/$DatasetId/refreshes" -Method Post -Body "{}"
Write-Host "Aguardando 10 segundos..."
Start-Sleep -Seconds 10

Read-Host "Pressione Enter para continuar"
