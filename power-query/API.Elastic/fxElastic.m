/*

DATAJUD_ELASTIC_HOST="https://api.datajud.cnj.jus.br"
DATAJUD_ELASTIC_PATH="view-processos-sigilo-*/_search"
DATAJUD_ELASTIC_USER="xpto@exemplo.jus.br"
DATAJUD_ELASTIC_PASS="pass"

*/

(elastic_attributes as list, sigla_tribunal as text, api_authorization as text, optional lastId as text) as list =>
let
    // elastic_attributes = { "id", "dadosBasicos.numero", "dadosBasicos.dataAjuizamento" },
    // sigla_tribunal = "TRTX",
    // api_authorization = fxAuthorization(),
    QueryBase = [
        size = 10000,
        _source = elastic_attributes,
        query = [
            bool = [
                must = {
                    [
                        match = [
                            siglaTribunal = sigla_tribunal
                        ]
                    ]
                }
            ]
        ]
    ],
    QuerySort = Record.AddField(QueryBase, "sort", { Record.AddField([], "id.keyword", "asc") }),
    Query =
        if lastId <> null then
            Record.AddField(QuerySort, "search_after", { lastId })
        else
            QuerySort,
    // jsonTexto = Text.FromBinary(Json.FromValue(Query)),
    Fonte = Web.Contents(
        DATAJUD_ELASTIC_HOST,
        [
            RelativePath = DATAJUD_ELASTIC_PATH,
            Headers = [
                #"Content-Type" = "application/json",
                Authorization = api_authorization
            ],
             Content = Json.FromValue(Query)
        ]
    ),
    JSON = Json.Document(Fonte),
    Resultado = JSON[hits][hits]
in
    Resultado
