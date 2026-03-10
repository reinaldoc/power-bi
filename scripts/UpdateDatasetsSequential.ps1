# Digitar no PowerShell: Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

$WarningPreference = "SilentlyContinue"

Write-Host "Iniciando Login..." -ForegroundColor Cyan
Login-PowerBI

$WorkspaceId = "00000000-1111-2222-3333-444444444444"

# Função para iniciar a atualização do modelo semântico e aguardar a conclusão
function Atualizar-Dataset {
    param (
        [string]$WorkspaceId,
        [string]$DatasetId,
        [string]$NomeDataset
    )

    Write-Host "Iniciando atualização do: $NomeDataset" -ForegroundColor Cyan
    
    # 1. Solicita atualização do modelo semântico (POST)
    $postUrl = "groups/$WorkspaceId/datasets/$DatasetId/refreshes"
    Invoke-PowerBIRestMethod -Url $postUrl -Method Post -Body "{}"
    
    Write-Host "Atualização solicitada. Aguardando processamento" -NoNewline
    
    # 2. Loop para verificar o status (GET)
    # Pega apenas o último histórico de atualização ($top=1)
    $getUrl = "groups/$WorkspaceId/datasets/$DatasetId/refreshes?`$top=1"
    $status = "Unknown"

    # No Power BI, 'Unknown' geralmente significa que está em andamento.
    while ($status -eq "Unknown" -or $status -eq "InProgress") {
        Start-Sleep -Seconds 120 
        
        $response = Invoke-PowerBIRestMethod -Url $getUrl -Method Get | ConvertFrom-Json
        
        if ($response.value.Count -gt 0) {
            $status = $response.value[0].status
        }
        
        Write-Host "." -NoNewline
    }

    Write-Host "`n"

    # 3. Valida se a atualização foi concluída com sucesso
    if ($status -eq "Completed") {
        Write-Host "SUCESSO: Atualização do $NomeDataset concluída!" -ForegroundColor Green
    } elseif ($status -eq "Failed") {
        Write-Host "ERRO: Falha na atualização do $NomeDataset." -ForegroundColor Red
        Write-Host "Interrompendo a execução do script para evitar erros em cascata." -ForegroundColor Red
        throw "A atualização do dataset $NomeDataset falhou. Verifique o portal do Power BI."
    } else {
        Write-Host "AVISO: Status inesperado ($status) no $NomeDataset." -ForegroundColor Yellow
    }
}

try {
    Atualizar-Dataset -WorkspaceId $WorkspaceId -DatasetId "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee" -NomeDataset "PAINEL_1"
    Atualizar-Dataset -WorkspaceId $WorkspaceId -DatasetId "zzzzzzzz-xxxx-wwww-yyyy-vvvvvvvvvvvv" -NomeDataset "PAINEL_2"
    Atualizar-Dataset -WorkspaceId $WorkspaceId -DatasetId "gggggggg-dddd-mmmm-uuuu-oooooooooooo" -NomeDataset "PAINEL_3"
    Write-Host "`nTodas as atualizações foram concluídas com sucesso!" -ForegroundColor Green
} catch {
    # Captura o erro (throw) caso algum dataset falhe e impede a execução dos próximos
    Write-Host "`nExecução abortada devido a um erro." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
}

Write-Host "`n"
Read-Host "Pressione Enter para continuar"
