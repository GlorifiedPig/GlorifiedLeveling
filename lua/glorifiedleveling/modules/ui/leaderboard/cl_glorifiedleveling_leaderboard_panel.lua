
local PANEL = {}

function PANEL:PerformLayout( w, h )
    self.TitleBar:Dock( TOP )
    self.TitleBar:SetSize( w, h * 0.1 )

    self.LeaderList:Dock( FILL )
    self.LeaderList:DockMargin( 10, 10, 10, 10 )
end

function PANEL:UpdateCache( leaderboardTbl )
    self:SetSize( ScrH() * 0.65, ScrH() * 0.6 )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedLeveling.Themes.GetCurrent()

    self.TitleBar = vgui.Create( "GlorifiedLeveling.Leaderboard.TitleBar", self )
    self.LeaderList = vgui.Create( "GlorifiedLeveling.Leaderboard.LeaderList", self )

    self:SetAlpha( 0 )
    self:AlphaTo( 255, 0.3 )
end

function PANEL:Think()
    if input.IsKeyDown( KEY_ESCAPE ) then
        GlorifiedLeveling.UI.CloseLeaderboard()
        RunConsoleCommand( "cancelselect" )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.leaderboardBackgroundColor )
end

vgui.Register( "GlorifiedLeveling.Leaderboard.Menu", PANEL, "EditablePanel" )

function GlorifiedLeveling.UI.OpenLeaderboard()
    if not IsValid( LocalPlayer() ) then return end

    if IsValid( GlorifiedLeveling.UI.Leaderboard ) then
        GlorifiedLeveling.UI.Leaderboard:Remove()
        GlorifiedLeveling.UI.Leaderboard = nil
    end

    GlorifiedLeveling.UI.Leaderboard = vgui.Create( "GlorifiedLeveling.Leaderboard.Menu" )
    GlorifiedLeveling.UI.Leaderboard:UpdateCache()
end

function GlorifiedLeveling.UI.CloseLeaderboard()
    if not GlorifiedLeveling.UI.Leaderboard then return end

    GlorifiedLeveling.UI.Leaderboard:AlphaTo( 0, 0.3, 0, function()
        if not GlorifiedLeveling.UI.Leaderboard then return end
        GlorifiedLeveling.UI.Leaderboard:Remove()
        GlorifiedLeveling.UI.Leaderboard = nil
    end )
end

concommand.Add( "glorifiedleveling_leaderboard", GlorifiedLeveling.UI.OpenLeaderboard )

hook.Add( "OnPlayerChat", "GlorifiedLeveling.LeaderboardPanel.OnPlayerChat", function( ply, text )
    if ply ~= LocalPlayer() or not text or text == "" then return end
    text = string.lower( text )
    local firstCharacter = string.sub( text, 1, 1 )
    if ( firstCharacter == "!" or firstCharacter == "/" ) and GlorifiedLeveling.Config.LEADERBOARD_OPEN_COMMANDS[string.sub( text, 2 )] and not GlorifiedLeveling.UI.Leaderboard then
        GlorifiedLeveling.UI.OpenLeaderboard()
        return true
    end
end )

hook.Add( "PlayerButtonDown", "GlorifiedLeveling.LeaderboardPanel.PlayerButtonDown", function( ply, button )
    if ply == LocalPlayer() and GlorifiedLeveling.Config.LEADERBOARD_KEY_ENABLED and button == GlorifiedLeveling.Config.LEADERBOARD_OPEN_KEY and not GlorifiedLeveling.UI.Leaderboard then
        GlorifiedLeveling.UI.OpenLeaderboard()
    end
end )