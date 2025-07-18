/*

  Function to convert binary imagem to HTML base64 string.

  How to use this function using [Content] column as binary image?

  BinaryToBase64 =
    Table.TransformColumns(
      PREVIOUS_STEP,
      {
        {"Content", fxFromBinaryToImageBase64, type text }
      }
    )

*/

(image as binary) as text =>
let
    Base64 = Binary.ToText(image, BinaryEncoding.Base64),
    ImageSrc = "data:image/jpg;base64," & Base64
in
    ImageSrc
