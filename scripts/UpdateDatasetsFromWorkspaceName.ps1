# Prompt: mostre como atualizar todos os modelos semânticos dado o nome de um
# workspace pelo Power Shell usando o módulo MicrosoftPowerBIMgmt.

# Nome do workspace
$workspaceName = "Nome do Seu Workspace"

# Autenticar no Power BI
Login-PowerBI

# Obter o ID do workspace pelo nome
$workspace = Get-PowerBIWorkspace -Scope Organization | Where-Object { $_.Name -eq $workspaceName }

if (-not $workspace) {
    Write-Host "Workspace '$workspaceName' não encontrado."
    return
}

$workspaceId = $workspace.Id
Write-Host "Workspace encontrado: ID = $workspaceId"

# Obter todos os datasets no workspace
$datasets = Get-PowerBIDataset -WorkspaceId $workspaceId

if (-not $datasets) {
    Write-Host "Nenhum dataset encontrado no workspace '$workspaceName'."
    return
}

Write-Host "Encontrados $($datasets.Count) datasets no workspace '$workspaceName'."

# Atualizar todos os datasets
foreach ($dataset in $datasets) {
    Write-Host "Iniciando atualização para o dataset: $($dataset.Name) (ID: $($dataset.Id))"

    try {
        Invoke-PowerBIRestMethod -Url "groups/$workspaceId/datasets/$($dataset.Id)/refreshes" -Method Post
        Write-Host "Atualização iniciada para o dataset: $($dataset.Name)"
    } catch {
        Write-Host "Erro ao iniciar atualização para o dataset: $($dataset.Name) - $_"
    }
}
