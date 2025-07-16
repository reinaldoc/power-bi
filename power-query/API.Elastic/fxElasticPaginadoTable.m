(elastic_attributes as list, sigla_tribunal as text, api_authorization as text) as table =>
let
    // elastic_attributes = { "id", "dadosBasicos.numero", "dadosBasicos.dataAjuizamento" },
    // sigla_tribunal = "TRTX",
    // api_authorization = fxAuthorization(),
    Fonte = fxElasticPaginado(elastic_attributes, sigla_tribunal, api_authorization),
    Lista = List.Combine(Fonte),
    ExtraiDados =
        List.Transform(
            Lista,
            each [
                id = _[_id],
                numero = _[_source][dadosBasicos][numero],
                dataAjuizamento = _[_source][dadosBasicos][dataAjuizamento]
            ]
        ),
    Resultado =
        Table.FromRecords(ExtraiDados, type table [ id = text, numero = text, dataAjuizamento = text])
in
    Resultado
