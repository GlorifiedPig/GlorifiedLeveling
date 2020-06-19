
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

        scrollBarCol = Color( 105, 105, 105 ),
        scrollBarHoverCol = Color( 85, 85, 85 ),

        dropdownBackgroundCol = Color( 33, 33, 33 ),
        dropdownBackgroundHoverCol = Color( 45, 45, 45 ),
        dropdownSelectedTextCol = Color( 255, 255, 255 ),

        logsMenuTransactionTypeTextCol = Color( 255, 255, 255 ),
        logsMenuTransactionTypeSelectCol = Color( 33, 33, 33 ),

        logsMenuLogBackgroundCol = Color( 33, 33, 33 ),
        logsMenuLogInfoTextCol = Color( 255, 255, 255 ),
        logsMenuLogPlayerNameTextCol = Color( 255, 255, 255 ),
        logsMenuLogPlayerSteamIDTextCol = Color( 160, 160, 160 ),
        logsMenuLogMoneyPositiveTextCol = Color( 87, 168, 50 ),
        logsMenuLogMoneyNegativeTextCol = Color( 205, 57, 57 ),
        logsMenuBackButtonCol = Color( 255, 255, 255 ),
        logsMenuBackButtonHoverCol = Color( 160, 160, 160 ),

        playersMenuSetButtonBackgroundCol = Color( 26, 134, 177 ),
        playersMenuSetButtonBackgroundHoverCol = Color( 31, 168, 223 ),
        playersMenuResetButtonBackgroundCol = Color( 205, 57, 57 ),
        playersMenuResetButtonBackgroundHoverCol = Color( 158, 41, 41 ),
        playersMenuTransactionsButtonBackgroundCol = Color( 74, 74, 74 ),
        playersMenuTransactionsButtonBackgroundHoverCol = Color( 50, 50, 50 ),
        playersMenuButtonTextCol = Color( 255, 255, 255 ),

        setBalanceButtonBackgroundCol = Color( 87, 168, 50 ),
        setBalanceButtonBackgroundHoverCol = Color( 62, 123, 32 ),
        setBalanceButtonTextCol = Color( 255, 255, 255 ),
        setBalanceEntryTextCol = Color( 74, 74, 74 ),
        setBalanceEntryBackgroundCol = Color( 255, 255, 255 ),

        resetBalanceYesButtonBackgroundCol = Color( 87, 168, 50 ),
        resetBalanceYesButtonBackgroundHoverCol = Color( 62, 123, 32 ),
        resetBalanceNoButtonBackgroundCol = Color( 205, 57, 57 ),
        resetBalanceNoButtonBackgroundHoverCol = Color( 158, 41, 41 )
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
        ["AdminMenu.LogPlayerInfo"] = {
            font = "Montserrat",
            size = function() return ScrH() * .0175 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.LogInfo"] = {
            font = "Montserrat",
            size = function() return ScrH() * .016 end,
            weight = 500,
            antialias = true
        },
        ["AdminMenu.LogInfoBold"] = {
            font = "Montserrat",
            size = function() return ScrH() * .016 end,
            weight = 700,
            antialias = true
        },
        ["AdminMenu.LogLevel"] = {
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