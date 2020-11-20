
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme
end

function PANEL:PerformLayout( w, h )
    self.PositionPos = w / 10
    self.NamePos = w / 1.8
    self.XPPos = w / 1.2
    self.LevelPos = w
end

function PANEL:Paint( w, h )
    local titleBarHeight = h / 12
    draw.RoundedBox( 8, 0, 0, w, h, Color( 73, 73, 73 ) )
    draw.RoundedBoxEx( 8, 0, 0, w, titleBarHeight, Color( 34, 34, 34 ), true, true )

    -- Let's draw some invisible lines just to help visualize where the labels will be placed.
    draw.RoundedBox( 0, self.PositionPos, 0, 1, h, Color( 255, 255, 255 ) ) -- Place indicator.
    draw.RoundedBox( 0, self.NamePos, 0, 1, h, Color( 255, 255, 255 ) ) -- Name indicator.
    draw.RoundedBox( 0, self.XPPos, 0, 1, h, Color( 255, 255, 255 ) ) -- XP indicator.

    draw.SimpleText( "#", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", self.PositionPos / 2, titleBarHeight / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( "Name", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", ( self.PositionPos + self.NamePos ) / 2, titleBarHeight / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( "XP", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", ( self.NamePos + self.XPPos ) / 2, titleBarHeight / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( "Level", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", ( self.XPPos + self.LevelPos ) / 2, titleBarHeight / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

vgui.Register( "GlorifiedLeveling.Leaderboard.LeaderList", PANEL, "Panel" )