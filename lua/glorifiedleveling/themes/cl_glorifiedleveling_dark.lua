
GlorifiedLeveling.Themes.Register( "Dark", GlorifiedLeveling.i18n.GetPhrase( "glDarkTheme" ), {
    Colors = {
        xpBarBackgroundDrawColor = Color( 31, 31, 31, 245 ),
        xpBarXPDrawColor = Color( 233, 5, 60 ),
        xpBarTextDrawColor = Color( 255, 255, 255 ),
        xpBarMultiplierDrawColor = Color( 255, 165, 5 ),
        xpBarMultiplierTextDrawColor = Color( 69, 69, 69 ),

        adminMenuBackgroundCol = Color( 50, 50, 50 ),
        adminMenuNavbarBackgroundCol = Color( 38, 38, 38 ),
        adminMenuNavbarItemCol = Color( 255, 255, 255 ),
        adminMenuNavbarSelectedItemCol = Color( 32, 133, 175 ),
        adminMenuNavbarLockdownCol = Color( 205, 57, 57 ),
        adminMenuCloseButtonCol = Color( 201, 60, 63 ),
        adminMenuCloseButtonHoverCol = Color( 134, 35, 37 ),
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
            size = 18,
            weight = 750,
            antialias = true
        },
        ["HUD.Multiplier"] = {
            font = "Roboto",
            size = 18,
            weight = 0,
            antialias = true
        },
        ["AdminMenu.NavbarItem"] = {
            font = "Montserrat",
            size = function() return ScrW() * 0.014 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.TransactionTypeSelect"] = {
            font = "Montserrat",
            size = function() return ScrH() * .021 end,
            weight = 500,
            antialias = true
        },
    },
    Materials = {
        logoSmall = Material( "glorifiedleveling/logo_small.png", "noclamp smooth" ),
        back = Material( "glorifiedleveling/back.png", "noclamp smooth" ),
        exit = Material( "glorifiedleveling/exit.png", "noclamp smooth" ),
        lockdown = Material( "glorifiedleveling/lockdown.png", "noclamp smooth" ),
        warning = Material( "glorifiedleveling/warning.png", "noclamp smooth" ),
        transfer = Material( "glorifiedleveling/transfer.png", "noclamp smooth" ),
        transaction = Material( "glorifiedleveling/transaction.png", "noclamp smooth" ),
        money = Material( "glorifiedleveling/money.png", "noclamp smooth" ),
        user = Material( "glorifiedleveling/user.png", "noclamp smooth" ),
        player = Material( "glorifiedleveling/player.png", "noclamp smooth" ),
        check = Material( "glorifiedleveling/check.png", "noclamp smooth" ),
        chevron = Material( "glorifiedleveling/chevron.png", "noclamp smooth" ),
        circle = Material( "glorifiedleveling/circle.png", "noclamp smooth" ),
        close = Material( "glorifiedleveling/close.png", "noclamp smooth" ),
        loading = Material( "glorifiedleveling/loading_spinner.png", "noclamp smooth" ),
        cursor = Material( "glorifiedleveling/cursor.png", "noclamp smooth" ),
        cursorHover = Material( "glorifiedleveling/cursor_hover.png", "noclamp smooth" ),
    }
} )
GlorifiedLeveling.Themes.GenerateFonts()