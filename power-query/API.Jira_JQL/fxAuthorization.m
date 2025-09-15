() as text =>
let
    Credentials =
      Binary.ToText(
          Text.ToBinary(API_JIRA_USER & ":" & API_JIRA_TOKEN),
          BinaryEncoding.Base64
      ),
    Auth = "Basic " & Credentials
in
    Auth
