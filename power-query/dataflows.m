let
    Fonte = PowerPlatform.Dataflows(null),
    Workspaces = Fonte{[Id="Workspaces"]}[Data],
    Dataflows = Table.TransformColumns(
        Workspaces,
        {
            "Data",
            each
               [
                   Dataflow = [dataflowName]{0},
                   Data = [Data]{0}
               ]
        }
    ),
    #"Dataflow Expandido" = Table.ExpandRecordColumn(Dataflows, "Data", {"Dataflow", "Data"}, {"Dataflow", "Data"}),
    #"Entity Expandido" = Table.ExpandTableColumn(#"Dataflow Expandido", "Data", {"entity"}, {"Tables"}),
    #"Outras Colunas Removidas" = Table.SelectColumns(#"Entity Expandido",{"workspaceName", "Dataflow", "Tables"}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Outras Colunas Removidas",{{"workspaceName", type text}, {"Dataflow", type text}, {"Tables", type text}})
in
    #"Tipo Alterado"
