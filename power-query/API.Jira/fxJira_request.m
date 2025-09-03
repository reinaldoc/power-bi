/*

API_JIRA_HOST="https://tenant.atlassian.net"
API_JIRA_PATH="/rest/api/3/search"
API_JIRA_USER="user@domain"
API_JIRA_TOKEN="token"

*/

(projects as list, fields as list, optional maxResults as number, optional startAt as number) as record =>
let
    // projects = {"Projeto A", "Projeto B"},
    // fields = {"summary", "duedate", "assignee", "status", "parent"},
    MaxResults =
        if maxResults = null then
            100
        else
            maxResults,
    StartAt =
        if startAt = null then
            0
        else
            startAt,
    Projects = Text.Combine(projects, ", "),
    Body = [
        jql = "project IN (" & Projects & ")",
        fields = fields,
        maxResults = MaxResults,
        startAt = StartAt
    ],
    Fonte =
        Web.Contents(
            API_JIRA_HOST,
            [
                RelativePath = API_JIRA_PATH,
                Headers = [
                    Authorization = fxAuthorization(),
                    #"Content-Type" = "application/json",
                    #"Accept" = "application/json"
                ],
                Content = Json.FromValue(Body)
            ]
        ),
    Data = Json.Document(Fonte)
in
    Data
