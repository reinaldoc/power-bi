let
    Fonte = (ZIPFile as binary) as table => 
let
    // ZIPFile =
    //     Table.SelectRows(
    //         Folder.Files(PLANILHA_DIRETORIO),
    //         each Text.EndsWith([Name], ".zip")
    //     ){0}[Content],
    fxHeader =
        BinaryFormat.Record(
            [
                MiscHeader    = BinaryFormat.Binary(14),
                BinarySize    = BinaryFormat.ByteOrder(BinaryFormat.UnsignedInteger32, ByteOrder.LittleEndian),
                FileSize      = BinaryFormat.ByteOrder(BinaryFormat.UnsignedInteger32, ByteOrder.LittleEndian),
                FileNameLen   = BinaryFormat.ByteOrder(BinaryFormat.UnsignedInteger16, ByteOrder.LittleEndian),
                ExtrasLen     = BinaryFormat.ByteOrder(BinaryFormat.UnsignedInteger16, ByteOrder.LittleEndian)    
            ]
        ),
    fxUnzip =
        (data as binary) as function =>
            let
                header = fxHeader(data)
            in
                BinaryFormat.Record(
                    [
                        IsValid  = true,
                        Filename = BinaryFormat.Text(header[FileNameLen]), 
                        Extras   = BinaryFormat.Text(header[ExtrasLen]), 
                        Content  =
                            BinaryFormat.Transform(
                                BinaryFormat.Binary(header[BinarySize]),
                                (x) => try Binary.Buffer(Binary.Decompress(x, Compression.Deflate)) otherwise null
                            )
                    ]
                ),
    HeaderChoice =
        BinaryFormat.Choice(
            BinaryFormat.ByteOrder(BinaryFormat.UnsignedInteger32, ByteOrder.LittleEndian),
            each if _ <> 67324752
                then
                    BinaryFormat.Record([IsValid = false, Filename=null, Extras=null, Content=null])
                else
                    BinaryFormat.Choice(
                        BinaryFormat.Binary(26),    // Header payload - 14+4+4+2+2
                        fxUnzip,
                        type binary
                    )
        ),

    // (content as binary) as list
    fxUnzipFormat =
        BinaryFormat.List(
            HeaderChoice,
            each _[IsValid]
        ),

    ListContent = fxUnzipFormat(ZIPFile),

    Entries =
        List.Transform(
            List.Select(ListContent, each [IsValid]),
            (r) => [Name = r[Filename], Content = r[Content] ]
        ),

    Resultado = Table.FromRecords(Entries)
in
    Resultado
in
    Fonte
