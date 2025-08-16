(path as text, page as number) as list =>
let
    //page = 1,
    //path = "book/5cf5805fb53e011a64671582/chapter",
    Fonte =
        Web.Contents(
            "https://the-one-api.dev",
            [
                RelativePath = "v2/" & path,
                Query = [
                    limit = "10",
                    page = Number.ToText(page)
                ]
                // Headers = [
                //     Authorization = "Bearer use-the-api-key"
                // ]
            ]
        ),
    JSON = Json.Document(Fonte),
    Resultado = JSON[docs]
in
    Resultado
