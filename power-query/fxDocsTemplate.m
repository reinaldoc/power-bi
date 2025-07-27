/*
    Exemplo de função documentada.
    Essas informações são apresentadas ao clicar na função.
*/

Value.ReplaceType(
    (valor1, valor2) =>
        let
            Etapa1 = valor1 + valor2
        in
            Etapa1,
    type function (valor1 as number, valor2 as number) as number meta [
        Documentation.Name = "SomaValores",
        Documentation.LongDescription = "Esta função retorna a soma de dois números.",
        Documentation.Description = "Soma dois valores",
        Documentation.Examples = {
        [
            Description = "Exemplo da função SomaValores()",
            Code = "SomaValores(10, 20)",
            Result = "30"
        ]
        }
    ]
)
