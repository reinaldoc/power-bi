(workspace_Id as text, dataflow_Id as text, table_name as text) as table =>
let
    Fonte = PowerPlatform.Dataflows(null),
    Workspaces = Fonte{[Id="Workspaces"]}[Data],
    WS = Workspaces{[workspaceId=workspace_Id]}[Data],
    DF = WS{[dataflowId=dataflow_Id]}[Data],
    Tabela = DF{[entity=table_name,version=""]}[Data]
in
    Tabela
