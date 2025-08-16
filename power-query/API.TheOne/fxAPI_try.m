(path as text, page as number) as list =>
let
    //page = 1,
    //path = "book/5cf5805fb53e011a64671582/chapter",
    Err = try fxAPI_request(path, page),
    Resultado =
        if Err[HasError] then
            Function.InvokeAfter(
                () => fxAPI_try(path, page),
                #duration(0,0,0,10)
            )
        else
            Err[Value]
in
    Resultado
