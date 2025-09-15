let
    projects = {"Projeto A", "Projeto B"},
    fields = {"summary", "duedate", "assignee", "status", "parent"},
    Data = fxJira_request(projects, fields, 1),
    Issue = Data[issues]{0},
    Schema = Issue[fields]
in
    Schema
