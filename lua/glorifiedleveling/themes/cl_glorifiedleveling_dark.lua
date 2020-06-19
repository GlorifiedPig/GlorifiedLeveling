
GlorifiedLeveling.Themes.Register( "Dark", GlorifiedLeveling.i18n.GetPhrase( "glDarkTheme" ), {
    Colors = {
        xpBarBackgroundDrawColor = Color( 31, 31, 31, 245 ),
        xpBarXPDrawColor = Color( 233, 5, 60 ),
        xpBarTextDrawColor = Color( 255, 255, 255 ),

        adminMenuBackgroundCol = Color( 69, 69, 69 )
    },
    Fonts = {
        ["HUD.Level"] = {
            font = "Roboto",
            size = 24,
            weight = 0,
            antialias = true
        },
        ["HUD.Experience"] = {
            font = "Arial",
            size = 20,
            weight = 1000,
            antialias = true
        },
        ["HUD.Multiplier"] = {
            font = "Roboto",
            size = 20,
            weight = 1000,
            antialias = true
        },
    }
} )
GlorifiedLeveling.Themes.GenerateFonts()