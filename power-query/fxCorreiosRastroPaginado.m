(objetos as list, optional pageSize as number) as list =>
let
    // objetos = { "XX111111111BR", "XX222222222BR", "XX333333333BR" },
    defaultPageSize = 10,
    pageSizeValue =
        if pageSize <> null then
            pageSize
        else
            defaultPageSize,
    splitList =
        List.Generate(
            () => 0,
            each _ < List.Count(objetos),
            each _ + pageSizeValue,
            each fxCorreiosRastro(List.Range(objetos, _, pageSizeValue))
        ),
    Resultado = List.Combine(splitList)
in
    Resultado
