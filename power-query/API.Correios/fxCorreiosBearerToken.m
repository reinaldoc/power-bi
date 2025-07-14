/*

CORREIOS_HOST="https://api.correios.com.br"
CORREIOS_AUTH_PATH="/token/v1/autentica/cartaopostagem"
CORREIOS_AUTH_USER="username"
CORREIOS_AUTH_PASS="password"
CORREIOS_AUTH_CARTAO_POSTAGEM="numero_cartao_postagem"

*/

() as text =>
let
    Credentials =
      Binary.ToText(
          Text.ToBinary(CORREIOS_AUTH_USER & ":" & CORREIOS_AUTH_PASS),
          BinaryEncoding.Base64
      ),
    Fonte = Web.Contents(
        CORREIOS_HOST,
        [
            RelativePath = CORREIOS_AUTH_PATH,
            Headers = [
                #"Content-Type" = "application/json",
                Authorization = "Basic " & Credentials
            ],
            Content = Json.FromValue([numero = CORREIOS_AUTH_CARTAO_POSTAGEM])
        ]
    ),
    JSON = Json.Document(Fonte),
    Token = JSON[token]
in
    Token
