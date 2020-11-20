
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme
    self.PlayerTable = {
        [1] = {
            Name = "GlorifiedPig",
            XP = 5214,
            Level = 2
        },
        [2] = {
            Name = "SomeBruh",
            XP = 4631,
            Level = 2
        },
        [3] = {
            Name = "Doctor Internet",
            XP = 3413,
            Level = 2
        },
        [4] = {
            Name = "Someone",
            XP = 2312,
            Level = 2
        },
        [5] = {
            Name = "The Dinkster",
            XP = 1246,
            Level = 2
        },
        [6] = {
            Name = "Who's moms is this?",
            XP = 450,
            Level = 2
        },
        [7] = {
            Name = "TESTING THE CHARACTER LIMIT",
            XP = 550,
            Level = 1
        },
        [8] = {
            Name = "I like to break things at it's core",
            XP = 450,
            Level = 1
        },
        [9] = {
            Name = "Aeiou",
            XP = 350,
            Level = 1
        },
        [10] = {
            Name = "Lorem Ipsum",
            XP = 200,
            Level = 1
        }
    }
end

function PANEL:PerformLayout( w, h )
    self.PositionPos = w / 10
    self.NamePos = w / 1.7
    self.XPPos = w / 1.2
    self.LevelPos = w

    self.PositionWidth = self.PositionPos
    self.NameWidth = self.NamePos - self.PositionPos
    self.XPWidth = self.XPPos - self.NamePos
    self.LevelWidth = self.LevelPos - self.XPPos
end

function PANEL:Paint( w, h )
    local titleBarHeight = h / 12
    draw.RoundedBox( 8, 0, 0, w, h, Color( 73, 73, 73 ) )
    draw.RoundedBoxEx( 8, 0, 0, w, titleBarHeight, Color( 34, 34, 34 ), true, true )

    draw.SimpleText( "#", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", self.PositionPos / 2, titleBarHeight / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( "Name", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", ( self.PositionPos + self.NamePos ) / 2, titleBarHeight / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( "XP", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", ( self.NamePos + self.XPPos ) / 2, titleBarHeight / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( "Level", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", ( self.XPPos + self.LevelPos ) / 2, titleBarHeight / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    if #self.PlayerTable > 0 then
        local gapSize = h / 135
        for k, v in ipairs( self.PlayerTable ) do
            local tblHeight = h / 12
            local tblY = titleBarHeight + ( ( k - 1 ) * tblHeight ) + ( k * gapSize )

            local firstBoxW = self.PositionWidth - 8
            draw.RoundedBoxEx( 8, 4, tblY, firstBoxW, tblHeight, Color( 51, 51, 51 ), true, false, true, false )
            draw.RoundedBoxEx( 8, 8 + firstBoxW, tblY, w - firstBoxW - 12, tblHeight, Color( 51, 51, 51 ), false, true, false, true )

            draw.SimpleText( k, "GlorifiedLeveling.Leaderboard.LeaderboardPositionText", self.PositionPos - self.PositionWidth / 2, tblY + tblHeight / 2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            local name = string.sub( v.Name, 1, string.len( v.Name ) >= 28 and 28 or string.len( v.Name ) )
            draw.SimpleText( name, "GlorifiedLeveling.Leaderboard.LeaderboardText", self.NamePos - self.NameWidth + 8, tblY + tblHeight / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

            local xpBoxX = self.XPPos - self.XPWidth + 6
            local xpBoxWidth = self.XPWidth - 12
            draw.RoundedBox( 4, xpBoxX, tblY + 6, xpBoxWidth, tblHeight - 12, Color( 89, 175, 63 ) )
            draw.SimpleText( string.Comma( v.XP ), "GlorifiedLeveling.Leaderboard.LeaderboardBoxText", xpBoxX + xpBoxWidth / 2, tblY + tblHeight / 2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

            local levelBoxX = self.LevelPos - self.LevelWidth + 8
            local levelBoxWidth = self.LevelWidth - 20
            draw.RoundedBox( 4, levelBoxX, tblY + 6, levelBoxWidth, tblHeight - 12, Color( 89, 175, 63 ) )
            draw.SimpleText( string.Comma( v.Level ), "GlorifiedLeveling.Leaderboard.LeaderboardBoxText", levelBoxX + levelBoxWidth / 2, tblY + tblHeight / 2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end
    else
        draw.SimpleText( "There is nobody here :(", "DermaDefault", 5, titleBarHeight + 5, Color( 255, 255, 255 ) )
    end

    --[[
        -- Let's draw some debug lines just to help visualize where the labels will be placed.
        draw.RoundedBox( 0, self.PositionPos, 0, 1, h, Color( 255, 255, 255 ) ) -- Place indicator.
        draw.RoundedBox( 0, self.NamePos, 0, 1, h, Color( 255, 255, 255 ) ) -- Name indicator.
        draw.RoundedBox( 0, self.XPPos, 0, 1, h, Color( 255, 255, 255 ) ) -- XP indicator.
    ]]--
end

vgui.Register( "GlorifiedLeveling.Leaderboard.LeaderList", PANEL, "Panel" )