(image as binary) as text =>
let
    Base64 = Binary.ToText(image, BinaryEncoding.Base64),
    ImageSrc = "data:image/jpg;base64," & Base64
in
    ImageSrc
