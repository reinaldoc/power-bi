(path as text) as table =>
let
    Pages =
        List.Generate(
            () => [page = 1, content = fxAPI_try(path, page) ],
            each not List.IsEmpty([content]),
            each [page = [page] + 1, content = fxAPI_try(path, page)],
            each [content]
        ),
    Valores = List.Combine(Pages),
    Tabela = Table.FromRecords(Valores, null, MissingField.UseNull)
in
    Tabela
