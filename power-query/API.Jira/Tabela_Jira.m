let
    projects = {"Project A", "Projeto B"},
    fields = {"summary", "duedate", "assignee", "status", "parent", "customfield_10644", "customfield_10842" },
    Data = fxJira_paginated(projects, fields),
    Issues =
        List.Transform(
            Data,
            each [
                id = Number.From([id]),
                key = [key],
                link = API_JIRA_HOST & "/browse/" & key,
                summary = [fields][summary]
            ]
        ),
    Tabela =
        Table.FromRecords(
            Issues,
            type table [id = Int64.Type, key = text, summary = text, link = text]
        )

in
    Tabela
