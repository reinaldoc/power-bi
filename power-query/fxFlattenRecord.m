(inputRecord as record, optional parentKey as nullable text) as record =>
let
    // inputRecord =
    //     [
    //         _source = [
    //             id = "1",
    //             dadosBasicos = [
    //                 numero = "123",
    //                 dataAjuizamento = "01/01/2025"
    //             ]
    //         ]
    //     ],
    prefix = if parentKey <> null then parentKey & "." else "",
    keys = Record.FieldNames(inputRecord),
    flattened =
        List.Combine(
            List.Transform(
                keys,
                (key) =>
                    let
                        value = Record.Field(inputRecord, key),
                        fullKey = prefix & key,
                        result =
                            if Value.Is(value, type record) then
                                { fxFlattenRecord(value, fullKey) }
                            else if Value.Is(value, type list) then
                                {
                                    Record.FromList(
                                        { Text.Combine(List.Transform(value, each Text.From(_)), ", ") },
                                        { fullKey }
                                    )
                                }
                            else
                                {
                                    Record.FromList({ value }, { fullKey })
                                }
                    in
                        result
            )
        ),
    combinado = Record.Combine(flattened)
in
    combinado
