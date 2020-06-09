
local PANEL = {}

function PANEL:Init()
    self:SetSize( ScrH() * 0.746, ScrH() * 0.8 )
    self:Center()
    self:MakePopup()
    self.Theme = GlorifiedBanking.Themes.GetCurrent()
    self:SetAlpha( 0 )
    self:AlphaTo( 255, 0.3 )
end

function PANEL:PerformLayout( w, h )
    self.Navbar:Dock( TOP )
    self.Navbar:SetSize( w, h * 0.06 )

    if IsValid( self.Page ) then
        self.Page:Dock( FILL )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.adminMenuBackgroundCol )
end

vgui.Register( "GlorifiedLeveling.AdminMenu", PANEL, "EditablePanel" )