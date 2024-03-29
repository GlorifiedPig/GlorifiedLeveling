
if not GlorifiedLeveling.Config.XP_BAR_ENABLED then return end

local ply

local glConfig = GlorifiedLeveling.Config
local gli18n = GlorifiedLeveling.i18n

local oldXP = 0
local themeData = GlorifiedLeveling.Themes.GetCurrent().Data
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
    end

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

local rainbowPhysgunEnabled = GlorifiedLeveling.Config.MAX_LEVEL_RAINBOW_PHYSGUN
hook.Add( "Think", "GlorifiedLeveling.RainbowPhysgun.Think", function()
    if not rainbowPhysgunEnabled then return end
    if not ply then ply = LocalPlayer() end

    if ply and ply:Alive() and GlorifiedLeveling.GetPlayerLevel() >= GlorifiedLeveling.Config.MAX_LEVEL and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() == "weapon_physgun" then
        local rainbowCol = rainbowColor( 15 )
        ply:SetWeaponColor( Vector( rainbowCol.r / 255, rainbowCol.g / 255, rainbowCol.b / 255 ) )
    end
end )

local levelUpAlpha = 0
local barAlpha = 0
local plyLeveledUp = false
hook.Add( "GlorifiedLeveling.LevelUp", "GlorifiedLeveling.HUD.PlayerLeveledUp", function( leveledPly )
    if leveledPly ~= LocalPlayer() then return end
    plyLeveledUp = true
    if timer.Exists( "GlorifiedLeveling.LevelUpdatedRemovalTimer" ) then timer.Start( "GlorifiedLeveling.LevelUpdatedRemovalTimer" ) end
    timer.Create( "GlorifiedLeveling.LevelUpdatedRemovalTimer", 5, 1, function()
        plyLeveledUp = false
    end )
end )

hook.Add( "GlorifiedLeveling.XPUpdated", "GlorifiedLeveling.HUD.XPUpdated", function( gainedPly )
    if gainedPly ~= LocalPlayer() then return end
    plyGainedXP = true
    if timer.Exists( "GlorifiedLeveling.XPUpdatedRemovalTimer" ) then timer.Start( "GlorifiedLeveling.XPUpdatedRemovalTimer" ) end
    timer.Create( "GlorifiedLeveling.XPUpdatedRemovalTimer", 10, 1, function()
        plyGainedXP = false
    end )
end )

hook.Add( "HUDPaint", "GlorifiedLeveling.HUD.HUDPaint", function()
    if not ply then ply = LocalPlayer() end

    local playerLevel = GlorifiedLeveling.GetPlayerLevel()
    local maxLevel = playerLevel >= GlorifiedLeveling.Config.MAX_LEVEL

    local finalBarAlpha = 0
    if ( GlorifiedLeveling.Config.SHOW_BAR_ON_XP_GAIN_ONLY and plyGainedXP ) or ( not GlorifiedLeveling.Config.SHOW_BAR_ON_XP_GAIN_ONLY and not maxLevel ) or ( GlorifiedLeveling.Config.SHOW_BAR_ON_MAX_LEVEL_ALWAYS and maxLevel ) or ( input.IsKeyDown( GlorifiedLeveling.Config.SHOW_BAR_KEY ) ) then finalBarAlpha = 255 end
    barAlpha = Lerp( FrameTime() * 8, barAlpha, finalBarAlpha )

    local xpBarBackgroundColor = ColorAlpha( themeData.Colors.xpBarBackgroundDrawColor, barAlpha )

    if not maxLevel then
        local playerXP = GlorifiedLeveling.GetPlayerXP()
        local playerMaxXP = GlorifiedLeveling.GetPlayerMaxXP()

        oldXP = Lerp( FrameTime() * 4, oldXP, playerXP )
        local roundedOldXP = string.Comma( math.Round( oldXP ) )
        local percentage = math.Clamp( ( oldXP / playerMaxXP ) * ( xpBarWidth - 15 ), 0, xpBarWidth - 15 )

        draw.RoundedBoxEx( 15, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 10, xpBarWidth, xpBarHeight, xpBarBackgroundColor, false, true, false, true )
        draw.RoundedBoxEx( 10, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 16, percentage, 20, ColorAlpha( themeData.Colors.xpBarXPDrawColor, barAlpha ), false, true, false, true )

        surface.SetDrawColor( xpBarBackgroundColor )
        draw.NoTexture()
        drawCircle( barOffsetWidth - xpBarWidth / 2 - 15, barOffsetHeight + 27, 22, 180 )
        draw.SimpleText( playerLevel, "GlorifiedLeveling.HUD.Level", barOffsetWidth - xpBarWidth / 2 - 16, barOffsetHeight + 28, ColorAlpha( themeData.Colors.xpBarTextDrawColor, barAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

        if plyLeveledUp or levelUpAlpha ~= 0 then
            levelUpAlpha = Lerp( FrameTime(), levelUpAlpha, plyLeveledUp and 255 or 0 )
            surface.SetFont( "GlorifiedLeveling.HUD.LevelUp" )
            local levelUpWidth = surface.GetTextSize( gli18n.GetPhrase( "glLevelUp" ) )
            draw.RoundedBox( 17, barOffsetWidth - 15 - levelUpWidth / 2 - 15, barOffsetHeight + levelUpTextOffset - 10, levelUpWidth + 30, 34, ColorAlpha( themeData.Colors.xpBarBackgroundDrawColor, math.Clamp( levelUpAlpha, 0, themeData.Colors.xpBarBackgroundDrawColor.a ) ) )
            draw.SimpleText( gli18n.GetPhrase( "glLevelUp" ), "GlorifiedLeveling.HUD.LevelUp", barOffsetWidth - 15 - levelUpWidth / 2, barOffsetHeight + levelUpTextOffset - 5, rainbowColor( 100, levelUpAlpha ) )
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

            surface.SetDrawColor( ColorAlpha( multiplierDrawColor, barAlpha ) )
            draw.NoTexture()
            drawCircle( barOffsetWidth + xpBarWidth / 2 + 20, barOffsetHeight + 26, 16, 180 )

            draw.SimpleText( "x" .. glConfig.MULTIPLIER_AMOUNT_CUSTOMFUNC( ply ), "GlorifiedLeveling.HUD.Multiplier", barOffsetWidth + xpBarWidth / 2 + 20, barOffsetHeight + 26, ColorAlpha( themeData.Colors.xpBarMultiplierTextDrawColor, barAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end

        if playerXP / playerMaxXP > 0.3 then
            draw.SimpleText( roundedOldXP .. " XP", "GlorifiedLeveling.HUD.Experience", barOffsetWidth - xpBarWidth / 2 + percentage / 2, barOffsetHeight + 26, ColorAlpha( themeData.Colors.xpBarTextDrawColor, barAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        else
            if playerXP / playerMaxXP > 0.05 then
                draw.SimpleText( roundedOldXP .. " XP", "GlorifiedLeveling.HUD.Experience", barOffsetWidth - xpBarWidth / 2 + percentage + 8, barOffsetHeight + 26, ColorAlpha( themeData.Colors.xpBarTextDrawColor, barAlpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
            else
                draw.SimpleText( roundedOldXP .. " XP", "GlorifiedLeveling.HUD.Experience", barOffsetWidth - 15, barOffsetHeight + 26, ColorAlpha( themeData.Colors.xpBarTextDrawColor, barAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            end
        end
    else
        draw.RoundedBoxEx( 15, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 10, xpBarWidth, xpBarHeight, xpBarBackgroundColor, false, true, false, true )
        if glConfig.MAX_LEVEL_RAINBOW_XP_BAR then
            draw.RoundedBoxEx( 10, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 16, xpBarWidth - 8, 20, ColorAlpha( rainbowColor( 15 ), barAlpha ), false, true, false, true )
            draw.SimpleTextOutlined( gli18n.GetPhrase( "glMaxLevel"), "GlorifiedLeveling.HUD.Experience", barOffsetWidth - 15, barOffsetHeight + 26, ColorAlpha( themeData.Colors.xpBarTextDrawColor, barAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, barAlpha ) )
        else
            draw.RoundedBoxEx( 10, barOffsetWidth - xpBarWidth / 2, barOffsetHeight + 16, xpBarWidth - 8, 20, ColorAlpha( themeData.Colors.xpBarXPDrawColor, barAlpha ), false, true, false, true )
            draw.SimpleText( gli18n.GetPhrase( "glMaxLevel"), "GlorifiedLeveling.HUD.Experience", barOffsetWidth - 15, barOffsetHeight + 26, ColorAlpha( themeData.Colors.xpBarTextDrawColor, barAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end

        surface.SetDrawColor( xpBarBackgroundColor )
        draw.NoTexture()
        drawCircle( barOffsetWidth - xpBarWidth / 2 - 15, barOffsetHeight + 27, 22, 180 )
        if glConfig.MAX_LEVEL_RAINBOW_LEVEL_TEXT then
            draw.SimpleText( playerLevel, "GlorifiedLeveling.HUD.Level", barOffsetWidth - xpBarWidth / 2 - 16, barOffsetHeight + 28, ColorAlpha( rainbowColor( 15 ), barAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        else
            draw.SimpleText( playerLevel, "GlorifiedLeveling.HUD.Level", barOffsetWidth - xpBarWidth / 2 - 16, barOffsetHeight + 28, ColorAlpha( themeData.Colors.xpBarTextDrawColor, barAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end
    end
end )