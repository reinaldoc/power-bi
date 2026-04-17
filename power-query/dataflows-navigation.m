let
    Fonte = PowerPlatform.Dataflows(null),
    Workspaces = Fonte{[Id="Workspaces"]}[Data],
    // Esta etapa evita que uma navegação na coluna [Data] altere o código da etapa anterior.
    // Isso facilita apagar as etapas posteriores a essa que surjam da navegação na coluna [Data].
    #"Etapa dummy" = Workspaces
in
    #"Etapa dummy"
