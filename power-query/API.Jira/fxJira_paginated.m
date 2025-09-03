(projects as list, fields as list, optional maxResults as number) as list =>
let
    // projects = {"Projeto A", "Projeto B"},
    // fields = {"summary", "duedate", "assignee", "status", "parent"},
    MaxResults =
        if maxResults = null then
            100
        else
            maxResults,
    Pages =
        List.Generate(
            () => [startAt = 0, content = fxJira_request(projects, fields, MaxResults, 0) ],
            each not List.IsEmpty([content][issues]),
            each [startAt = [startAt] + MaxResults, content = fxJira_request(projects, fields, MaxResults, startAt)],
            each [content][issues]
        ),
    Data = List.Combine(Pages)
in
    Data
