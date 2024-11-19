let
    Fonte = PowerPlatform.Dataflows(null),
    Workspaces = Fonte{[Id="Workspaces"]}[Data],
    Dataflows = Table.TransformColumns(
        Workspaces,
        {
            "Data",
            each
               List.Zip({[dataflowName], [Data]})
        }
    ),
    #"Data Expandido" = Table.ExpandListColumn(Dataflows, "Data"),
    #"List to Record" = Table.TransformColumns(
        #"Data Expandido",
        {"Data", each [ Dataflow = _{0}, Table = _{1}]}
    ),
    #"Record Expandido" = Table.ExpandRecordColumn(#"List to Record", "Data", {"Dataflow", "Table"}),
    #"Table Expandido" = Table.ExpandTableColumn(#"Record Expandido", "Table", {"entity"}, {"Tables"}),
    #"Outras Colunas Removidas" = Table.SelectColumns(#"Table Expandido",{"workspaceName", "Dataflow", "Tables"}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Outras Colunas Removidas",{{"workspaceName", type text}, {"Dataflow", type text}, {"Tables", type text}})
in
    #"Tipo Alterado"
