
GlorifiedLeveling.Themes.Register( "Dark", GlorifiedLeveling.i18n.GetPhrase( "glDarkTheme" ), {
    Colors = {
        xpBarBackgroundDrawColor = Color( 0, 0, 0, 155 ),
        xpBarXPDrawColor = Color( 150, 0, 0, 255 ),

        adminMenuBackgroundCol = Color( 69, 69, 69 )
    },
    Fonts = {
        ["HUDLevel"] = {
            font = "Roboto",
            size = 24,
            weight = 0,
            antialias = true
        },
        ["HUDExperience"] = {
            font = "Arial",
            size = 20,
            weight = 1000,
            antialias = true
        }
    }
} )
GlorifiedLeveling.Themes.GenerateFonts()