/*

Use o consulta GoogleCalendars para identificar os IDs das agendas disponíveis.

G_CALENDAR_ID=""

*/

let
    AccessToken = fxOAuth_AccessToken(),
    CalendarId = Uri.EscapeDataString(G_CALENDAR_ID),
    Fonte =
        Json.Document(
            Web.Contents(
                API_ENDPOINT,
                [
                    RelativePath = "/calendar/v3/calendars/" & CalendarId & "/events",
                    Headers = [
                        Authorization = "Bearer " & AccessToken
                    ],
                    Query = [
                        singleEvents = "true",
                        maxResults = "2500",
                        timeMin = "2026-01-01T00:00:00Z",
                        TimeMax = "2028-02-10T23:59:59Z",
                        orderBy = "startTime"
                    ]
                ]
            )
        ),
    Eventos = Fonte[items],
    Tabela = Table.FromRecords(Eventos, null, MissingField.UseNull)
in
    Tabela