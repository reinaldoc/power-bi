let
    elastic_attributes = { "id", "dadosBasicos.numero", "dadosBasicos.dataAjuizamento" },
    sigla_tribunal = "TRTX",
    api_authorization = fxAuthorization(),
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
    Tabela =
        Table.FromRecords(
            ExtraiDados,
            type table [ id = text, numero = text, dataAjuizamento = text]
        )
in
    Tabela
