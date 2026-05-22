# Defina o caminho da pasta onde estão os arquivos zip
$srcDir = "C:\Power-BI\Estatística\Arquivo\2026-04"

# Defina o caminho onde os arquivos serão extraídos
$dstDir = "C:\Power-BI\Estatística"

# Busca todos os arquivos .zip no diretório
$zips = Get-ChildItem -Path $srcDir -Filter *.zip

foreach ($zip in $zips) {
    # Define o nome da pasta de destino baseada no nome do arquivo (sem a extensão .zip)
    $destination = Join-Path -Path $dstDir -ChildPath $zip.BaseName
    
    # Cria a pasta se ela ainda não existir
    if (!(Test-Path -Path $destination)) {
        New-Item -ItemType Directory -Path $destination
    }
    
    # Extrai o conteúdo para a pasta criada
    Expand-Archive -Path $zip.FullName -DestinationPath $destination -Force
}

Read-Host "Pressione Enter para continuar"
