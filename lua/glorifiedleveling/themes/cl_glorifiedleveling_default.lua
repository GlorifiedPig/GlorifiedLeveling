
GlorifiedLeveling.Themes.Register( "Default", GlorifiedLeveling.i18n.GetPhrase( "glDarkTheme" ), {
    Colors = {
        xpBarBackgroundDrawColor = Color( 31, 31, 31, 230 ),
        xpBarXPDrawColor = Color( 233, 5, 60 ),
        xpBarTextDrawColor = Color( 255, 255, 255 ),
        xpBarMultiplierDrawColor = Color( 249, 166, 2 ),
        xpBarMultiplierDrawColorDarker = Color( 222, 142, 0 ),
        xpBarMultiplierTextDrawColor = Color( 255, 255, 255 ),

        adminMenuBackgroundCol = Color( 50, 50, 50 ),
        adminMenuNavbarBackgroundCol = Color( 38, 38, 38 ),
        adminMenuNavbarItemCol = Color( 255, 255, 255 ),
        adminMenuNavbarSelectedItemCol = Color( 32, 133, 175 ),
        adminMenuNavbarLockdownCol = Color( 205, 57, 57 ),
        adminMenuCloseButtonCol = Color( 201, 60, 63 ),
        adminMenuCloseButtonHoverCol = Color( 134, 35, 37 ),

        scrollBarCol = Color( 105, 105, 105 ),
        scrollBarHoverCol = Color( 85, 85, 85 ),

        playerTopBarColor = Color( 255, 255, 255 ),
        playerBackgroundCol = Color( 33, 33, 33 ),
        playerInfoTextCol = Color( 255, 255, 255 ),
        playerNameTextCol = Color( 255, 255, 255 ),
        playerSteamIDTextCol = Color( 160, 160, 160 ),

        playersMenuSetButtonBackgroundCol = Color( 26, 134, 177 ),
        playersMenuSetButtonBackgroundHoverCol = Color( 31, 168, 223 ),
        playersMenuResetButtonBackgroundCol = Color( 205, 57, 57 ),
        playersMenuResetButtonBackgroundHoverCol = Color( 158, 41, 41 ),
        playersMenuAddButtonBackgroundCol = Color( 74, 74, 74 ),
        playersMenuAddButtonBackgroundHoverCol = Color( 50, 50, 50 ),
        playersMenuButtonTextCol = Color( 255, 255, 255 ),

        setLevelButtonBackgroundCol = Color( 87, 168, 50 ),
        setLevelButtonBackgroundHoverCol = Color( 62, 123, 32 ),
        setLevelButtonTextCol = Color( 255, 255, 255 ),
        setLevelEntryTextCol = Color( 74, 74, 74 ),
        setLevelEntryBackgroundCol = Color( 255, 255, 255 ),

        resetLevelYesButtonBackgroundCol = Color( 87, 168, 50 ),
        resetLevelYesButtonBackgroundHoverCol = Color( 62, 123, 32 ),
        resetLevelNoButtonBackgroundCol = Color( 205, 57, 57 ),
        resetLevelNoButtonBackgroundHoverCol = Color( 158, 41, 41 ),

        perkMenuBackgroundColor = Color( 51, 51, 51 ),
        perkMenuTitleBarBackgroundColor = Color( 34, 34, 34 ),
        perkMenuCloseButtonBackgroundColor = Color( 201, 60, 63 ),
        perkMenuCloseButtonHoverColor = Color( 134, 35, 37 ),
    },
    Fonts = {
        ["HUD.Level"] = {
            font = "Roboto",
            size = 24,
            weight = 0,
            antialias = true
        },
        ["HUD.Experience"] = {
            font = "Roboto",
            size = 18,
            weight = 0,
            antialias = true
        },
        ["HUD.Multiplier"] = {
            font = "Roboto",
            size = 18,
            weight = 0,
            antialias = true
        },
        ["HUD.LevelUp"] = {
            font = "Roboto",
            size = 24,
            bold = true,
            antialias = true
        },
        ["AdminMenu.NavbarItem"] = {
            font = "Montserrat",
            size = function() return ScrW() * 0.014 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.PlayersOnline"] = {
            font = "Montserrat",
            size = function() return ScrH() * .021 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.PlayerInfo"] = {
            font = "Montserrat",
            size = function() return ScrH() * .0175 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.PlayerLevel"] = {
            font = "Montserrat",
            size = function() return ScrH() * .024 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.PlayerSetLevel"] = {
            font = "Montserrat",
            size = function() return ScrH() * .017 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.SetLevelTitle"] = {
            font = "Montserrat",
            size = function() return ScrH() * .028 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.SetLevelDescription"] = {
            font = "Montserrat",
            size = function() return ScrH() * .024 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.SetLevelEntry"] = {
            font = "Montserrat",
            size = function() return ScrH() * .022 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.SetLevelButton"] = {
            font = "Montserrat",
            size = function() return ScrH() * .03 end,
            weight = 500,
            antialias = true
        },
    },
    Materials = {
        close = Material( "glorifiedleveling/close.png", "noclamp smooth" ),
    }
} )
GlorifiedLeveling.Themes.GenerateFonts()