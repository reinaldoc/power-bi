let
    Fonte = Table.FromList({0..86399}, Splitter.SplitByNothing()),
    Duracao = Table.AddColumn(
        Fonte,
        "Duração",
        each #duration(0,0,0, [Column1]),
        type duration
    ),
    Horas = Table.AddColumn(
      Duracao,
      "HorasDoDia",
      each #time(
        Duration.Hours([Duração]),
        Duration.Minutes([Duração]),
        Duration.Seconds([Duração])
        ),
      type time),
    RemoverColunas = Table.RemoveColumns(Horas, {"Duração", "Column1"}),
    Hora = Table.AddColumn(
      RemoverColunas, "Hora", each Time.Hour([HorasDoDia]), Int64.Type
      ),
    Minuto = Table.AddColumn(
      Hora, "Minuto", each Time.Minute([HorasDoDia]), Int64.Type
      ),
    Segundo = Table.AddColumn(
      Minuto, "Segundo", each Time.Second([HorasDoDia]), Int64.Type
      ),
    Periodo = 
        Table.AddColumn(Segundo, "Período", each 
            if      [Hora] >= 0  and [Hora] <= 5  then "Madrugada (0h - 6h)"
            else if [Hora] >= 6  and [Hora] <= 11 then "Manhã (6h - 12h)"
            else if [Hora] >= 12 and [Hora] <= 17 then "Tarde (12h - 18h)"
            else if [Hora] >= 18 and [Hora] <= 23 then "Noite (18h - 24h)"
            else "Nada", type text
            ),
    PeriodoOrdem = 
        Table.AddColumn(Periodo, "Período Ordem", each 
            if        [Hora] >= 0  and [Hora] <= 5  then 1
            else if   [Hora] >= 6  and [Hora] <= 11 then 2
            else if   [Hora] >= 12 and [Hora] <= 17 then 3
            else if   [Hora] >= 18 and [Hora] <= 23 then 4
            else 5, Int64.Type
        )

in
    PeriodoOrdem
