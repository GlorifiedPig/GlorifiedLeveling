
local PANEL = {}

function PANEL:PerformLayout( w, h )
    self.TitleBar:Dock( TOP )
    self.TitleBar:SetSize( w, h * 0.1 )
end

function PANEL:UpdateCache( perkTbl )
    local panelW, panelH = ScrH() * 0.8, ScrH() * 0.7
    local titleBarSize = panelH * 0.1

    self:SetSize( panelW, panelH )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedLeveling.Themes.GetCurrent()

    self.TitleBar = vgui.Create( "GlorifiedLeveling.PerkMenu.TitleBar", self )
    self.Perks = {}

    for k, v in ipairs( GlorifiedLeveling.Perks.PERK_INFO ) do
        local perkEntry = vgui.Create( "GlorifiedLeveling.PerkMenu.PerkEntry", self )
        perkEntry:SetPerk( k )
        local perkEntryHeight = panelH / 8
        perkEntry:SetSize( panelW - 30, perkEntryHeight )
        perkEntry:SetPos( 15, titleBarSize + ( ( k - 1 ) * perkEntryHeight ) + ( k * ( panelH / 48 ) ) )
        self.Perks[k] = perkEntry
    end

    self:SetAlpha( 0 )
    self:AlphaTo( 255, 0.3 )
end

function PANEL:Think()
    if input.IsKeyDown( KEY_ESCAPE ) then
        GlorifiedLeveling.UI.ClosePerkMenu()
        RunConsoleCommand( "cancelselect" )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.perkMenuBackgroundColor )
end

vgui.Register( "GlorifiedLeveling.PerkMenu.Menu", PANEL, "EditablePanel" )

function GlorifiedLeveling.UI.OpenPerkMenu()
    if not IsValid( LocalPlayer() ) then return end

    if IsValid( GlorifiedLeveling.UI.PerkMenu ) then
        GlorifiedLeveling.UI.PerkMenu:Remove()
        GlorifiedLeveling.UI.PerkMenu = nil
    end

    GlorifiedLeveling.UI.PerkMenu = vgui.Create( "GlorifiedLeveling.PerkMenu.Menu" )
    GlorifiedLeveling.UI.PerkMenu:UpdateCache()
end

function GlorifiedLeveling.UI.ClosePerkMenu()
    if not GlorifiedLeveling.UI.PerkMenu then return end

    GlorifiedLeveling.UI.PerkMenu:AlphaTo( 0, 0.3, 0, function()
        if not GlorifiedLeveling.UI.PerkMenu then return end
        GlorifiedLeveling.UI.PerkMenu:Remove()
        GlorifiedLeveling.UI.PerkMenu = nil
    end )
end

concommand.Add( "glorifiedleveling_perks", GlorifiedLeveling.UI.OpenPerkMenu )

hook.Add( "OnPlayerChat", "GlorifiedLeveling.PerkMenuPanel.OnPlayerChat", function( ply, text )
    if ply ~= LocalPlayer() or not text or text == "" then return end
    text = string.lower( text )
    local firstCharacter = string.sub( text, 1, 1 )
    if ( firstCharacter == "!" or firstCharacter == "/" ) and GlorifiedLeveling.Config.PERK_MENU_OPEN_COMMANDS[string.sub( text, 2 )] and not GlorifiedLeveling.UI.PerkMenu then
        GlorifiedLeveling.UI.OpenPerkMenu()
        return true
    end
end )

hook.Add( "PlayerButtonDown", "GlorifiedLeveling.PerkMenuPanel.PlayerButtonDown", function( ply, button )
    if ply == LocalPlayer() and GlorifiedLeveling.Config.PERK_MENU_KEY_ENABLED and button == GlorifiedLeveling.Config.PERK_MENU_OPEN_KEY and not GlorifiedLeveling.UI.PerkMenu then
        GlorifiedLeveling.UI.OpenPerkMenu()
    end
end )