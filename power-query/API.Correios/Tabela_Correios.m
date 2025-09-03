let
    objetos = { "XX111111111BR", "XX222222222BR", "XX333333333BR" },
    token = fxCorreiosBearerToken(),
    Rastro = fxCorreiosRastroPaginado(objetos, token),
    ExtrairDados =
        List.Transform(
            Rastro,
            each [
                API.Objeto = _[codObjeto]?,
                API.Rastro = _[eventos]?{0}?[descricao]?,
                API.Data_Situacao = try DateTime.From(_[eventos]{0}[dtHrCriado]) otherwise null
            ]
        ),
    Tabela =
        Table.FromRecords(
            ExtrairDados,
            type table [ API.Objeto = text, API.Rastro = text, API.Data_Situacao = datetime]
        )
in
    Tabela
