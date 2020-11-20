
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme
    self.PlayerTable = GlorifiedLeveling.TopTen or {}

    for k, v in ipairs( self.PlayerTable ) do
        self.PlayerTable[k].Name = ""
        steamworks.RequestPlayerInfo( v.SteamID64, function( playerName )
            self.PlayerTable[k].Name = playerName
        end )
    end
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
    local theme = self.Theme

    local titleBarHeight = h / 12
    draw.RoundedBox( 8, 0, 0, w, h, theme.Data.Colors.leaderboardLeaderListBackgroundColor )
    draw.RoundedBoxEx( 8, 0, 0, w, titleBarHeight, theme.Data.Colors.leaderboardLeaderListTopBarColor, true, true )

    draw.SimpleText( "#", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", self.PositionPos / 2, titleBarHeight / 2, theme.Data.Colors.leaderboardLeaderListTitlesColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( "Name", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", ( self.PositionPos + self.NamePos ) / 2, titleBarHeight / 2, theme.Data.Colors.leaderboardLeaderListTitlesColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( "XP", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", ( self.NamePos + self.XPPos ) / 2, titleBarHeight / 2, theme.Data.Colors.leaderboardLeaderListTitlesColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( "Level", "GlorifiedLeveling.Leaderboard.LeaderboardTitleBar", ( self.XPPos + self.LevelPos ) / 2, titleBarHeight / 2, theme.Data.Colors.leaderboardLeaderListTitlesColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    if #self.PlayerTable > 0 then
        local gapSize = h / 135
        for k, v in ipairs( self.PlayerTable ) do
            local tblHeight = h / 12
            local tblY = titleBarHeight + ( ( k - 1 ) * tblHeight ) + ( k * gapSize )

            local firstBoxW = self.PositionWidth - 8
            draw.RoundedBoxEx( 8, 4, tblY, firstBoxW, tblHeight, theme.Data.Colors.leaderboardLeaderListEntryBackgroundColor, true, false, true, false )
            draw.RoundedBoxEx( 8, 8 + firstBoxW, tblY, w - firstBoxW - 12, tblHeight, theme.Data.Colors.leaderboardLeaderListEntryBackgroundColor, false, true, false, true )

            local positionColor = theme.Data.Colors.leaderboardLeaderListEntryGeneralPositionColor
            if k == 1 then positionColor = theme.Data.Colors.leaderboardLeaderListEntryFirstPositionColor
            elseif k == 2 then positionColor = theme.Data.Colors.leaderboardLeaderListEntrySecondPositionColor
            elseif k == 3 then positionColor = theme.Data.Colors.leaderboardLeaderListEntryThirdPositionColor end

            local positionText = k .. "."
            draw.SimpleText( positionText, "GlorifiedLeveling.Leaderboard.LeaderboardPositionText", self.PositionPos - self.PositionWidth / 2, tblY + tblHeight / 2, positionColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

            local name = string.sub( v.Name, 1, string.len( v.Name ) >= 28 and 28 or string.len( v.Name ) )
            draw.SimpleText( name, "GlorifiedLeveling.Leaderboard.LeaderboardText", self.NamePos - self.NameWidth + 8, tblY + tblHeight / 2, theme.Data.Colors.leaderboardLeaderListEntryTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

            local xpBoxX = self.XPPos - self.XPWidth + 6
            local xpBoxWidth = self.XPWidth - 12
            draw.RoundedBox( 4, xpBoxX, tblY + 6, xpBoxWidth, tblHeight - 12, theme.Data.Colors.leaderboardLeaderListEntrySecondaryBackgroundColor )
            local xpText = tonumber( v.Level ) >= GlorifiedLeveling.Config.MAX_LEVEL and "MAX" or string.Comma( v.XP )
            draw.SimpleText( xpText, "GlorifiedLeveling.Leaderboard.LeaderboardBoxText", xpBoxX + xpBoxWidth / 2, tblY + tblHeight / 2, theme.Data.Colors.leaderboardLeaderListEntryTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

            local levelBoxX = self.LevelPos - self.LevelWidth + 8
            local levelBoxWidth = self.LevelWidth - 20
            draw.RoundedBox( 4, levelBoxX, tblY + 6, levelBoxWidth, tblHeight - 12, theme.Data.Colors.leaderboardLeaderListEntrySecondaryBackgroundColor )
            draw.SimpleText( string.Comma( v.Level ), "GlorifiedLeveling.Leaderboard.LeaderboardBoxText", levelBoxX + levelBoxWidth / 2, tblY + tblHeight / 2, theme.Data.Colors.leaderboardLeaderListEntryTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end
    else
        draw.SimpleText( "There is nobody here :(", "DermaDefault", 5, titleBarHeight + 5, theme.Data.Colors.leaderboardLeaderListEntryTextColor )
    end

    --[[
        -- Let's draw some debug lines just to help visualize where the labels will be placed.
        draw.RoundedBox( 0, self.PositionPos, 0, 1, h, Color( 255, 255, 255 ) ) -- Place indicator.
        draw.RoundedBox( 0, self.NamePos, 0, 1, h, Color( 255, 255, 255 ) ) -- Name indicator.
        draw.RoundedBox( 0, self.XPPos, 0, 1, h, Color( 255, 255, 255 ) ) -- XP indicator.
    ]]--
end

vgui.Register( "GlorifiedLeveling.Leaderboard.LeaderList", PANEL, "Panel" )