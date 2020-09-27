
local PANEL = {}

function PANEL:PerformLayout( w, h )
    self.TitleBar:Dock( TOP )
    self.TitleBar:SetSize( w, h * 0.1 )
end

function PANEL:SetPlayer( ply )
    self:SetSize( ScrH() * 0.55, ScrH() * 0.6 )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedLeveling.Themes.GetCurrent()

    self.TitleBar = vgui.Create( "GlorifiedLeveling.PerkMenu.TitleBar", self )

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
end

function GlorifiedLeveling.UI.ClosePerkMenu()
    if not GlorifiedLeveling.UI.PerkMenu then return end

    GlorifiedLeveling.UI.PerkMenu:AlphaTo( 0, 0.3, 0, function()
        if not GlorifiedLeveling.UI.PerkMenu then return end
        GlorifiedLeveling.UI.PerkMenu:Remove()
        GlorifiedLeveling.UI.PerkMenu = nil
    end )
end

concommand.Add( "testperks", GlorifiedLeveling.UI.OpenPerkMenu )