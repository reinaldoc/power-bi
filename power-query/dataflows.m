let
    Fonte = PowerPlatform.Dataflows(null),
    Workspaces = Fonte{[Id="Workspaces"]}[Data],
    Dataflows =
        Table.TransformColumns(
            Workspaces,
            {"Data", each [[dataflowName], [Data]]}
        ),
    #"Dataflow Expandido" =
        Table.ExpandTableColumn(
            Dataflows,
            "Data",
            {"dataflowName", "Data"}, {"Dataflow", "Data"}
        ),
    #"Tables Expandido" =
        Table.ExpandTableColumn(
            #"Dataflow Expandido",
            "Data",
            {"entity", "Data"},
            {"Tables", "Data"}
        ),
    #"Outras Colunas Removidas" =
        Table.SelectColumns(
            #"Tables Expandido",
            {"workspaceName", "Dataflow", "Tables", "Data"}
        ),
    #"Tipo Alterado" =
        Table.TransformColumnTypes(
            #"Outras Colunas Removidas",
            {{"workspaceName", type text}, {"Dataflow", type text}, {"Tables", type text}})
in
    #"Tipo Alterado"
