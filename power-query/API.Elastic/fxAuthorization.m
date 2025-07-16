() as text =>
let
    Credentials =
      Binary.ToText(
          Text.ToBinary(DATAJUD_ELASTIC_USER & ":" & DATAJUD_ELASTIC_PASS),
          BinaryEncoding.Base64
      ),
    Auth = "Basic " & Credentials
in
    Auth
