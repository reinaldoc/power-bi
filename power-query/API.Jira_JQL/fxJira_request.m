/*

API_JIRA_HOST="https://tenant.atlassian.net"
API_JIRA_PATH="/rest/api/3/search/jql"
API_JIRA_USER="user@domain"
API_JIRA_TOKEN="token"

A API não permite definir maxResults maior que 100.

*/

(projects as list, fields as list, optional limit as number, optional nextPageToken as text) as record =>
let
    // projects = {"Projeto A", "Projeto B"},
    // fields = {"summary", "duedate", "assignee", "status", "parent"},
    // maxResults = null,
    // nextPageToken = null,
    Projects = Text.Combine(projects, ", "),
    Body =
        if nextPageToken = null then
            [
                jql = "project IN (" & Projects & ")",
                fields = fields,
                maxResults = limit ?? 100
            ]
        else
            [
                jql = "project IN (" & Projects & ")",
                fields = fields,
                maxResults = limit ?? 100,
                nextPageToken = nextPageToken
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
