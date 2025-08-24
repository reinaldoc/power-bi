(t as table, nomesPorPosicao as record) as table =>
let
    // t =
    //     #table(
    //         type table [ Coluna_A = text, Coluna_B = number, Coluna_C = date ],
    //         {
    //             {"Reinaldo", 1.80, #date(1983, 11, 19) },
    //             {"Lara",     1.01, #date(2020, 12, 25) }
    //         }
    //     ),
    // nomesPorPosicao =
    //     [
    //         0 = "Nome",
    //         1 = "Altura",
    //         2 = "Idade"
    //     ],
    NomesColunas = Table.ColumnNames(t),
    NomesAlterados =
        List.Transform(
            List.Positions(NomesColunas),
            each
                if Record.HasFields(nomesPorPosicao, Text.From(_)) then
                    Record.Field(nomesPorPosicao, Text.From(_))
                else
                    NomesColunas{_}
        ),
    AlterarNomesColunas =
        Table.RenameColumns(
            t,
            List.Zip({NomesColunas, NomesAlterados})
        )
in
    AlterarNomesColunas
