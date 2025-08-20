let
    Fonte =
        #table(
            {"Pedido", "Moeda", "Valor"},
            {
                {1, "BRL", 300},
                {2, "BRL", 400},
                {3, "USD", 100}
            }
        ),
    Resultado =
        Table.FromRecords(
            Table.TransformRows(
                Fonte,
                each Record.TransformFields(
                    _,
                    { 
                        { "Pedido", (p) => "P" & Text.PadStart(Text.From(p), 5, "0") },
                        { "Moeda",  (m) => "BRL" },
                        { "Valor",  (v) => if [Moeda] = "USD" then v * 5 else v }
                    }
                )
            )
        )
in
    Resultado
