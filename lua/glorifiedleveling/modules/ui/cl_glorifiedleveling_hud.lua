
local ply
local xpBarMat = Material("glorifiedleveling/xp_bar.png", "noclamp smooth")

hook.Add( "HUDPaint", "GlorifiedLeveling.HUD.HUDPaint", function()
    if not ply then ply = LocalPlayer() end

    surface.SetMaterial( xpBarMat )
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() / 2 - 450, 0, 900, 40 )
end )