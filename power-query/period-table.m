let
    // função fxDatas() para obter uma lista contínua de datas.
    fxDatas =
        (data_inicial as date, data_final as date) as list =>
        let
            Dias_entre_datas = Duration.Days(data_final - data_inicial) + 1,
            Datas = List.Dates(data_inicial, Dias_entre_datas, #duration(1,0,0,0))
        in
            Datas,

    // função fxPeriodos() para obter uma tabela para um determinado período de datas.
    fxPeriodos =
        (rotulo as text, data_inicial as date, data_final as date, ordem as number) as table =>
        let
            Datas = fxDatas(data_inicial, data_final),
            Tabela =
                #table(
                    type table [ Data = date, Periodo = text, Ordem = number],
                    List.Transform(
                        Datas,
                        each { _ , rotulo , ordem }
                    )
                )
        in
            Tabela,

    hoje =                  Date.From(DateTimeZone.UtcNow() - #duration(0, 3, 0, 0), "pt-BR"),
    ontem =                 Date.AddDays(hoje, -1),
    semana_inicio =         Date.StartOfWeek(hoje),
    semana_passada_inicio = Date.AddDays(semana_inicio, -7),
    semana_passada_fim    = Date.EndOfWeek(semana_passada_inicio),
    mes_inicio =            Date.StartOfMonth(hoje),
    mes_passado_inicio =    Date.AddMonths(mes_inicio, -1),
    ano_inicio =            Date.StartOfYear(hoje),
    ano_passado_inicio =    Date.AddYears(ano_inicio, -1),
    
    periodos = {
        {"Hoje", hoje, hoje, 1},
        {"Ontem", ontem, ontem, 2},

        // Dias fechados, não inclui hoje.
        {"Últimos 7 Dias", Date.AddDays(hoje, -7), ontem, 3},
        {"Últimos 14 até 8 dias", Date.AddDays(hoje, -15), Date.AddDays(hoje, -8), 4},
        {"Últimos 30 dias", Date.AddDays(hoje, -30), ontem, 5},
        {"Últimos 60 até 31 dias", Date.AddDays(hoje, -60), Date.AddDays(hoje, -31), 6},
        {"Últimos 365 dias", Date.AddDays(hoje, -365), ontem, 7},

        // Inclui hoje
        {"Esta Semana", semana_inicio, hoje, 8},
        {"Semana Passada", semana_passada_inicio, semana_passada_fim, 8},
        {"Este Mês", mes_inicio, hoje, 1},
        {"Mês Passado", mes_passado_inicio, Date.EndOfMonth(mes_passado_inicio), 12},
        {"Este Ano", ano_inicio, Date.EndOfYear(hoje), 13},
        {"Ano Passado", ano_passado_inicio, Date.EndOfYear(ano_passado_inicio), 14}
    },

    tabelas = List.Transform(periodos, each fxPeriodos( _{0}, _{1}, _{2}, _{3} ) ),
    tabela = Table.Combine(tabelas)
in
    tabela
