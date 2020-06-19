
local ply
local xpBarMat = Material( "glorifiedleveling/xp_bar.png", "noclamp smooth" )

local oldXP = 0
local themeData = GlorifiedLeveling.Themes.GetCurrent().Data

hook.Add( "HUDPaint", "GlorifiedLeveling.HUD.HUDPaint", function()
    if not ply then ply = LocalPlayer() end

    local playerXP = GlorifiedLeveling.GetPlayerXP()
    local playerMaxXP = GlorifiedLeveling.GetPlayerMaxXP()

    oldXP = Lerp( FrameTime() * 6, oldXP, playerXP )
    local percentage = ( oldXP / playerMaxXP ) * 748

    surface.SetDrawColor( themeData.Colors.xpBarBackgroundDrawColor )
    surface.DrawRect( ScrW() / 2 - 347, 7, 748, 26 )

    surface.SetDrawColor( themeData.Colors.xpBarXPDrawColor )
    surface.DrawRect( ScrW() / 2 - 347, 7, percentage, 26 )

    surface.SetMaterial( xpBarMat )
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() / 2 - 450, 0, 900, 40 )
end )