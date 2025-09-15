(projects as list, fields as list, optional maxResults as number) as list =>
let
    // projects = {"Projeto A", "Projeto B"},
    // fields = {"summary", "duedate", "assignee", "status", "parent"},
    // maxResults = null,
    Pages =
        List.Generate(
            () => [
                content = fxJira_request(projects, fields, maxResults ?? 100),
                token = content[nextPageToken]
            ],
            each [content] <> null,
            each [
                content = if [token] = null then null else fxJira_request(projects, fields, maxResults ?? 100, [token]),
                token = content[nextPageToken]?
            ],
            each [content][issues]
        ),
    Data = List.Combine(Pages)
in
    Data
