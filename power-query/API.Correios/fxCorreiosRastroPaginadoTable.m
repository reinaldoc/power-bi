(objetos as list, token as text) as table =>
let
    // token = fxCorreiosBearerToken(),
    // objetos = { "XX111111111BR", "XX222222222BR", "XX333333333BR" },
    Rastro = fxCorreiosRastroPaginado(objetos, token),
    ExtrairDados =
      List.Transform(
          Rastro,
          each [
                API.Objeto = _[codObjeto],
                API.Rastro = try _[eventos]{0}[descricao] otherwise null,
                API.Data_Situacao = try DateTime.From(_[eventos]{0}[dtHrCriado]) otherwise null
        ]
      ),
    Resultado =
      Table.FromRecords(
          ExtrairDados,
          type table [ API.Objeto = text, API.Rastro = text, API.Data_Situacao = datetime]
      )
in
    Resultado
