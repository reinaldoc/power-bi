/*

Como obter OAUTH_CLIENT_ID e OAUTH_SECRET_ID?

1. Acesse: https://console.cloud.google.com
2. Selecione: APIs e serviços -> Criar credenciais -> ID do cliente OAuth
3. Configure a opção "URIs de redirecionamento autorizados" para https://developers.google.com/oauthplayground
4. Habilite a API que será utilizada em: APIs e serviços -> Biblioteca
  - Google Calendar API: https://www.googleapis.com/auth/calendar.readonly

Como obter o OAUTH_REFRESH_TOKEN?

1. Acesse: https://developers.google.com/oauthplayground
2. Configure o CLIENT_ID e o SECRET_ID na engrenagem, opção "Use your own OAuth credentials"
  - isso permite obter um REFRESH_TOKEN que não expira;
3. No Step 1, selecione a API que será utilizada, clique em "Authorize APIs" e faça login.
  - por exemplo: https://www.googleapis.com/auth/calendar.readonly
4. Clique em "Exchange authorization code for tokens" para obter o REFRESH_TOKEN.

OAUTH_CLIENT_ID=""
OAUTH_SECRET_ID=""
OAUTH_REFRESH_TOKEN=""

*/

() as text =>
let
    TokenResponse =
        Json.Document(
            Web.Contents(
                OAUTH_ENDPOINT,
                [
                    Content = Text.ToBinary(
                        "client_id=" & Uri.EscapeDataString(OAUTH_CLIENT_ID) &
                        "&client_secret=" & Uri.EscapeDataString(OAUTH_SECRET_ID) &
                        "&refresh_token=" & Uri.EscapeDataString(OAUTH_REFRESH_TOKEN) &
                        "&grant_type=refresh_token"
                    ),
                    Headers = [
                        #"Content-Type" = "application/x-www-form-urlencoded"
                    ]
                ]
            )
        ),
    AccessToken = TokenResponse[access_token]
in
    AccessToken
