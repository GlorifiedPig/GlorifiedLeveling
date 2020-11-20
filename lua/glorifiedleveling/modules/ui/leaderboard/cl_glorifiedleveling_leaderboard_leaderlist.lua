
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0 ) )
end

vgui.Register( "GlorifiedLeveling.Leaderboard.LeaderList", PANEL, "Panel" )