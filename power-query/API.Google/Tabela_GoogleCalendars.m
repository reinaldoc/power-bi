/*

Consulta para listar os calendários disponíveis.

O valor da coluna "id" deve ser usada para montar a URL da API:
"https://www.googleapis.com/calendar/v3/calendars/[id]/events"

*/

let
    AccessToken = fxOAuth_AccessToken(),

    Fonte =
        Json.Document(
            Web.Contents(
                "https://www.googleapis.com/calendar/v3/users/me/calendarList",
                [
                    Headers = [
                        Authorization = "Bearer " & AccessToken
                    ]
                ]
            )
        ),
    items = Fonte[items],
    Tabela = Table.FromRecords(items, null, MissingField.UseNull)
in
    Tabela
