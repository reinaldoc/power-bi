let
    Fonte =
        DateTime.From(
            DateTimeZone.RemoveZone(DateTimeZone.UtcNow() - #duration(0, 3, 0, 0)),
            "pt-BR"
        ),
    Tabela =
        #table(
            type table [Date = datetime],
            {
                {Fonte}
            }
        )
in
    Tabela
