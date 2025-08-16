let
    Fonte = List.Buffer(D_Book[_id]),
    Valores =
        List.Transform(
            Fonte,
            (book_id) =>
                let
                    Chapters = fxAPI_paginated("book/" & book_id & "/chapter"),
                    Tabela = Table.AddColumn(
                        Chapters,
                        "_id_book",
                        each book_id
                    )
                in
                    Tabela
        ),
    Tabela = Table.Combine(Valores)
in
    Tabela
