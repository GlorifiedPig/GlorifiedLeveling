
if not GlorifiedLeveling.Config.XP_BAR_ENABLED then return end

local ply

local glConfig = GlorifiedLeveling.Config
local gli18n = GlorifiedLeveling.i18n

local oldXP = 0
local themeData = GlorifiedLeveling.Themes.GetCurrent().Data -- {{ user_id | 98804 }}
local multiplierDrawColor = table.Copy( themeData.Colors.xpBarMultiplierDrawColor )
local multiplierApproachingDark = true

local xpBarWidth
local xpBarHeight = 31
local barOffsetWidth
local barOffsetHeight
local levelUpTextOffset = 56

local function SetScreenVars()
    xpBarWidth = glConfig.XP_BAR_WIDTH()
    barOffsetWidth = glConfig.XP_BAR_WIDTH_OFFSET( xpBarWidth )
    barOffsetHeight = glConfig.XP_BAR_HEIGHT_OFFSET( xpBarHeight )
    if glConfig.LEVEL_UP_ON_TOP then
        levelUpTextOffset = -10
    end
end
SetScreenVars()
hook.Add( "OnScreenSizeChanged", "GlorifiedLeveling.HUD.OnScreenSizeChanged", SetScreenVars )

local function drawCircle( x, y, radius, seg )
    local cir = {}

    table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
    for i = 0, seg do
        local a = math.rad( ( i / seg ) * -360 )
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
    end -- {{ user_id sha256 vqnpoqdd }}

    local a = math.rad( 0 )
    table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

    surface.DrawPoly( cir )
end

local function approachColor( from, to, amount )
    from.r = math.Approach( from.r, to.r, amount )
    from.g = math.Approach( from.g, to.g, amount )
    from.b = math.Approach( from.b, to.b, amount )
    return from
end

local function rainbowColor( speed, alpha )
    local rainbowCol = HSVToColor( CurTime() * speed % 360, 1, 1 )
    if alpha then return ColorAlpha( rainbowCol, alpha )
    else return rainbowCol end
end

local levelUpAlpha = 0
local plyLeveledUp = false
hook.Add( "GlorifiedLeveling.LevelUp", "GlorifiedLeveling.HUD.PlayerLeveledUp", function()
    plyLeveledUp = true
    timer.Simple( 8, function()
        plyLeveledUp = false
    end )
end )

hook.Add( "HUDPaint", "GlorifiedLeveling.HUD.HUDPaint", function()
    if not ply then ply = LocalPlayer() end

    local playerLevel = GlorifiedLeveling.GetPlayerLevel()

    if playerLevel < GlorifiedLeveling.Config.MAX_LEVEL then
        local playerXP = GlorifiedLeveling.GetPlayerXP()
        local playerMaxXP = GlorifiedLeveling.GetPlayerMaxXP()

        oldXP = Lerp( FrameTime() * 4, oldXP, playerXP )
        local roundedOldXP = string.Comma( math.Round( oldXP ) )
        local percentage = math.Clamp( ( oldXP / playerMaxXP ) * ( xpBarWidth - 15 ), 0, xpBarWidth - 15 )

        draw.RoundedBoxEx( 15, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 10, xpBarWidth, xpBarHeight, themeData.Colors.xpBarBackgroundDrawColor, false, true, false, true )
        draw.RoundedBoxEx( 10, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 16, percentage, 20, themeData.Colors.xpBarXPDrawColor, false, true, false, true )

        surface.SetDrawColor( themeData.Colors.xpBarBackgroundDrawColor.r, themeData.Colors.xpBarBackgroundDrawColor.g, themeData.Colors.xpBarBackgroundDrawColor.b )
        draw.NoTexture()
        drawCircle( barOffsetWidth - xpBarWidth / 2 - 15, barOffsetHeight + 27, 22, 180 )
        draw.SimpleText( playerLevel, "GlorifiedLeveling.HUD.Level", barOffsetWidth - xpBarWidth / 2 - 16, barOffsetHeight + 28, themeData.Colors.xpBarTextDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

        if plyLeveledUp or levelUpAlpha != 0 then
            if not plyLeveledUp then
                levelUpAlpha = Lerp( FrameTime(), levelUpAlpha, 0 )
            else
                levelUpAlpha = Lerp( FrameTime(), levelUpAlpha, 255 )
            end
            draw.SimpleTextOutlined( gli18n.GetPhrase( "glLevelUp" ), "GlorifiedLeveling.HUD.LevelUp", barOffsetWidth - 15, barOffsetHeight + levelUpTextOffset, rainbowColor( 100, levelUpAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, levelUpAlpha ) )
        end

        if glConfig.MULTIPLIER_AMOUNT_CUSTOMFUNC( ply ) > 1 then
            if multiplierApproachingDark then
                multiplierDrawColor = approachColor( multiplierDrawColor, themeData.Colors.xpBarMultiplierDrawColorDarker, 0.1 )
                if multiplierDrawColor == themeData.Colors.xpBarMultiplierDrawColorDarker then
                    multiplierApproachingDark = false
                end
            else
                multiplierDrawColor = approachColor( multiplierDrawColor, themeData.Colors.xpBarMultiplierDrawColor, 0.1 )
                if multiplierDrawColor == themeData.Colors.xpBarMultiplierDrawColor then
                    multiplierApproachingDark = true
                end
            end

            surface.SetDrawColor( multiplierDrawColor )
            draw.NoTexture()
            drawCircle( barOffsetWidth + xpBarWidth / 2 + 20, barOffsetHeight + 26, 16, 180 )

            draw.SimpleText( "x" .. glConfig.MULTIPLIER_AMOUNT_CUSTOMFUNC( ply ), "GlorifiedLeveling.HUD.Multiplier", barOffsetWidth + xpBarWidth / 2 + 20, barOffsetHeight + 26, themeData.Colors.xpBarMultiplierTextDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end

        if playerXP / playerMaxXP > 0.3 then
            draw.SimpleText( roundedOldXP .. " XP", "GlorifiedLeveling.HUD.Experience", barOffsetWidth - xpBarWidth / 2 + percentage / 2, barOffsetHeight + 26, themeData.Colors.xpBarTextDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        else
            if playerXP / playerMaxXP > 0.05 then
                draw.SimpleText( roundedOldXP .. " XP", "GlorifiedLeveling.HUD.Experience", barOffsetWidth - xpBarWidth / 2 + percentage + 8, barOffsetHeight + 26, themeData.Colors.xpBarTextDrawColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
            else
                draw.SimpleText( roundedOldXP .. " XP", "GlorifiedLeveling.HUD.Experience", barOffsetWidth - 15, barOffsetHeight + 26, themeData.Colors.xpBarTextDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            end
        end
    else
        draw.RoundedBoxEx( 15, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 10, xpBarWidth, xpBarHeight, themeData.Colors.xpBarBackgroundDrawColor, false, true, false, true )
        if glConfig.MAX_LEVEL_RAINBOW_XP_BAR then
            draw.RoundedBoxEx( 10, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 16, xpBarWidth - 8, 20, rainbowColor( 15 ), false, true, false, true )
            draw.SimpleTextOutlined( gli18n.GetPhrase( "glMaxLevel"), "GlorifiedLeveling.HUD.Experience", barOffsetWidth - 15, barOffsetHeight + 26, themeData.Colors.xpBarTextDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
        else
            draw.RoundedBoxEx( 10, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 16, xpBarWidth - 8, 20, themeData.Colors.xpBarXPDrawColor, false, true, false, true )
            draw.SimpleText( gli18n.GetPhrase( "glMaxLevel"), "GlorifiedLeveling.HUD.Experience", barOffsetWidth - 15, barOffsetHeight + 26, themeData.Colors.xpBarTextDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end

        surface.SetDrawColor( themeData.Colors.xpBarBackgroundDrawColor.r, themeData.Colors.xpBarBackgroundDrawColor.g, themeData.Colors.xpBarBackgroundDrawColor.b )
        draw.NoTexture()
        drawCircle( barOffsetWidth - xpBarWidth / 2 - 15, barOffsetHeight + 27, 22, 180 )
        if glConfig.MAX_LEVEL_RAINBOW_LEVEL_TEXT then
            draw.SimpleText( playerLevel, "GlorifiedLeveling.HUD.Level", barOffsetWidth - xpBarWidth / 2 - 16, barOffsetHeight + 28, rainbowColor( 15 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        else
            draw.SimpleText( playerLevel, "GlorifiedLeveling.HUD.Level", barOffsetWidth - xpBarWidth / 2 - 16, barOffsetHeight + 28, themeData.Colors.xpBarTextDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end
    end
end )