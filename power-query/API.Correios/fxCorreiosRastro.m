(objetos as list, token as text) as list =>
let
    // token = fxCorreiosBearerToken(),
    // objetos = { "XX111111111BR", "XX222222222BR", "XX333333333BR" },
    CodigosObjetos =
        Text.Combine(
            List.Transform(
                objetos,
                each "codigosObjetos=" & Text.From(_) & "&"
            )
        ),
    Fonte = Web.Contents(
        CORREIOS_HOST,
        [
            RelativePath = CORREIOS_RASTRO_PATH & "?" & CodigosObjetos & "resultado=U",
            Headers = [
                Authorization = "Bearer " & token
            ]
        ]
    ),
    JSON = Json.Document(Fonte),
    Resultado = JSON[objetos]
in
    Resultado
