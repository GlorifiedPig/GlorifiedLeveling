
local PANEL = {}

function PANEL:Init()
    net.Start( "GlorifiedLeveling.AdminPanel.PlayerListOpened" )
    net.SendToServer()

    self.Theme = self:GetParent().Theme

    self.TopBar = vgui.Create( "Panel", self )
    self.TopBar.Theme = self:GetParent().Theme
    self.TopBar.Paint = function( s, w, h )
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glPlayersOnline", #self.Players ), "GlorifiedLeveling.AdminMenu.PlayersOnline", w * 0.024, h * 0.46, self.Theme.Data.Colors.playerTopBarColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    end

    self.ScrollPanel = vgui.Create( "GlorifiedLeveling.ScrollPanel", self )

    self.Players = {}
end

function PANEL:AddPlayer( ply, level )
    local playerid = #self.Players + 1

    self.Players[playerid] = vgui.Create( "GlorifiedLeveling.Player", self.ScrollPanel )
    self.Players[playerid].Theme = self.Theme
    self.Players[playerid].CanEditPlayers = self.CanEditPlayers
    self.Players[playerid]:AddPlayer( ply, level )
end

function PANEL:ResetPlayers()
    self.ScrollPanel:Clear()
    table.Empty( self.Players )
end

function PANEL:PerformLayout( w, h )
    self.TopBar:SetSize( w, h * 0.05 )
    self.TopBar:Dock( TOP )

    self.ScrollPanel:Dock( FILL )
    self.ScrollPanel:DockMargin( 0, 0, 0, h * 0.02 )
    self.ScrollPanel:DockPadding( 0, 0, w * 0.013, 0 )

    local plyh = h * 0.08
    local plymarginx, plymarginy = w * 0.026, h * 0.008
    for k,v in ipairs( self.Players ) do
        v:SetHeight( plyh )
        v:Dock( TOP )
        v:DockMargin( plymarginx, plymarginy, plymarginx, plymarginy )
    end
end

vgui.Register( "GlorifiedLeveling.Players", PANEL, "Panel" )

net.Receive( "GlorifiedLeveling.AdminPanel.PlayerListOpened.SendInfo", function()
    local playersLevels = util.JSONToTable( net.ReadLargeString() )
    if not playersLevels then return end

    local panel = GlorifiedLeveling.UI.AdminMenu.Page
    if not panel.ResetPlayers then return end

    panel:ResetPlayers()

    for k,v in ipairs( player.GetAll() ) do
        panel:AddPlayer( v, playersLevels[v:SteamID()] or -1 )
    end
end )