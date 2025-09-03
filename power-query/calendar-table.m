let
    Hoje = Date.From(DateTimeZone.UtcNow() - #duration(0, 3, 0, 0)),
    // Ou defina as datas iniciais e finais
    Coluna_data  = {
        #date(2025, 1, 1),   // data com ano inicial
        Hoje                 // data com ano final
    },
    // Ou indique a coluna de datas da Tabela Fato
    // Coluna_data  = List.Buffer(F_Vendas[Data]),
    Data_minima  = List.Min(Coluna_data),
    Data_maxima  = List.Max(Coluna_data),
    Data_inicial = Date.StartOfYear(Data_minima),
    Data_final   = Date.EndOfYear(Data_maxima),
    Total_dias   = Duration.Days(Data_final - Data_inicial) + 1,
    Datas        = List.Dates(Data_inicial, Total_dias, #duration(1, 0, 0, 0)),
    Fonte        =
        #table(
            type table [
                Date = date,
                Ano = Int64.Type,
                Mês = Int64.Type,
                Mês por extenso = text,
                Dia = Int64.Type,
                Dia da semana = Int64.Type,
                Dia da semana por extenso = text,
                #"Mês/Ano" = text,
                #"Mês/Ano atual" = text,
                #"Mês/Ano ordenada" = Int64.Type,
                Trimestre = text,
                Semestre = text,
                Passado da fato = logical,
                Futuro da fato = logical
            ],
            List.Transform(
                Datas, each {
                    _,
                    Date.Year(_),
                    Date.Month(_),
                    Text.Proper(Date.MonthName(_)),
                    Date.Day(_),
                    Date.DayOfWeek(_),
                    Date.DayOfWeekName(_),
                    Text.Combine({
                        Text.Start(Date.MonthName(_), 3),
                        "/",
                        Text.From(Date.Year(_))
                    }),
                    if Date.Year(Hoje) = Date.Year(_) and Date.Month(Hoje) = Date.Month(_) then
                        "Mês atual"
                    else
                        Text.Combine({
                            Text.Start(Date.MonthName(_), 3),
                            "/",
                            Text.From(Date.Year(_))
                        }),
                    (Date.Year(_) - Date.Year(Data_inicial)) * 12 + Date.Month(_),
                    Text.From(Date.QuarterOfYear(_)) & "º Trim.",
                    if Date.Month(_) <= 6 then "1º Sem." else "2º Sem.",
                    _ < Data_minima,
                    _ > Data_maxima
                }
            )
       )
in
    Fonte
