(objetos as list, token as text, optional pageSize as number) as list =>
let
    // token = fxCorreiosBearerToken(),
    // objetos = { "XX111111111BR", "XX222222222BR", "XX333333333BR" },
    defaultPageSize = 50,
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
            each
                Function.InvokeAfter(
                    () => fxCorreiosRastro(List.Range(objetos, _, pageSizeValue), token),
                    #duration(0, 0, 0, 1)
                )
        ),
    Resultado = List.Combine(splitList)
in
    Resultado
