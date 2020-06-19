
local ply
local xpBarMat = Material( "glorifiedleveling/xp_bar.png", "noclamp smooth" )

local oldXP = 0
local themeData = GlorifiedLeveling.Themes.GetCurrent().Data

local xpBarWidth
local function SetScreenVars()
    xpBarWidth = ScrH() * 0.7
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

hook.Add( "HUDPaint", "GlorifiedLeveling.HUD.HUDPaint", function()
    if not ply then ply = LocalPlayer() end

    local playerLevel = GlorifiedLeveling.GetPlayerLevel()
    local playerXP = GlorifiedLeveling.GetPlayerXP()
    local playerMaxXP = GlorifiedLeveling.GetPlayerMaxXP()

    oldXP = Lerp( FrameTime() * 4, oldXP, playerXP )
    local percentage = ( oldXP / playerMaxXP ) * ( xpBarWidth - 15 )

    draw.RoundedBox( 16, ScrW() / 2 - xpBarWidth / 2, 10, xpBarWidth, 31, Color( 31, 31, 31, 245 ) )

    draw.RoundedBox( 10, ScrW() / 2 - ( xpBarWidth - 15 ) / 2, 16, percentage, 20, Color( 233, 5, 60 ) )

    surface.SetDrawColor( 31, 31, 31 )
    draw.NoTexture()
    drawCircle( ScrW() / 2 - xpBarWidth / 2, 27, 22, 180 )

    draw.SimpleText( playerLevel, "GlorifiedLeveling.HUDLevel", ScrW() / 2 - xpBarWidth / 2 - 1, 28, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    if oldXP / playerMaxXP > 0.3 then
        draw.SimpleText( playerXP .. " XP", "GlorifiedLeveling.HUDExperience", ScrW() / 2 - xpBarWidth / 2 + percentage / 2, 25, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    else
        draw.SimpleText( playerXP .. " XP", "GlorifiedLeveling.HUDExperience", ScrW() / 2 - xpBarWidth / 2 + percentage + 12, 25, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    end

    --[[surface.SetDrawColor( themeData.Colors.xpBarBackgroundDrawColor )
    surface.DrawRect( ScrW() / 2 - 347, 7, 748, 26 )

    surface.SetDrawColor( themeData.Colors.xpBarXPDrawColor )
    surface.DrawRect( ScrW() / 2 - 347, 7, percentage, 26 )

    surface.SetMaterial( xpBarMat )
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() / 2 - 450, 0, 900, 40 )]]--
end )