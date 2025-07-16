(elastic_attributes as list, sigla_tribunal as text, api_authorization as text) as list =>
let
    // elastic_attributes = { "id", "dadosBasicos.numero", "dadosBasicos.dataAjuizamento" },
    // sigla_tribunal = "TRTX",
    // api_authorization = fxAuthorization(),
    Fonte =
        List.Generate(
            () => [pagina = 0, ultimoId = null, dados = fxElastic(elastic_attributes, sigla_tribunal, api_authorization)],
            each List.Count([dados]) > 0,
            //each [pagina] < 5,
            each [
                pagina = [pagina] + 1,
                ultimoId = Record.Field(List.Last([dados]), "_id"),
                dados = fxElastic(elastic_attributes, sigla_tribunal, api_authorization, ultimoId)
            ],
            each [dados]
        )
in
    Fonte
