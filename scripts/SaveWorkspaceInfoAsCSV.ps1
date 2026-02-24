# Requires MicrosoftPowerBIMgmt Module
#  - Install-PSResource -Name MicrosoftPowerBIMgmt

$WarningPreference = "SilentlyContinue"

Login-PowerBI

@("workspaces", "reports", "dashboards", "datasets") | foreach {
    $csvFile = $_ + ".csv"
    if(Test-Path $csvFile) { Remove-Item $csvFile }
}

$workspaces = Get-PowerBIWorkspace -Scope Organization -All
$workspaces | Export-Csv "workspaces.csv" -NoTypeInformation

foreach($ws in $workspaces) {
    $reports = Get-PowerBIReport -WorkspaceId $ws.id -Scope Organization;
    $reports | Add-Member -NotePropertyName workspaceId -NotePropertyValue $ws.id;
    $reports | Export-Csv "reports.csv" -NoTypeInformation -Append;

    $dashs = Get-PowerBIDashboard -WorkspaceId $ws.id -Scope Organization;
    $dashs | Add-Member -NotePropertyName workspaceId -NotePropertyValue $ws.id;
    $dashs | Export-Csv "dashboards.csv" -NoTypeInformation -Append;

    $sms = Get-PowerBIDataset -WorkspaceId $ws.id -Scope Organization;
    $sms | Add-Member -NotePropertyName workspaceId -NotePropertyValue $ws.id;
    $sms | Export-Csv "datasets.csv" -NoTypeInformation -Append;
}
