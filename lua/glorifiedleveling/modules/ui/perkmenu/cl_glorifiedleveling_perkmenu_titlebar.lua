
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.TitleLabel = vgui.Create( "DLabel", self )
    self.TitleLabel:SetFont( "GlorifiedLeveling.PerkMenu.TitleBar" )
    self.TitleLabel:SetText( "Perk Menu" )
    self.TitleLabel:SizeToContents()
    self.TitleLabel:DockMargin( 10, 0, 0, 0 )
    self.TitleLabel:Dock( LEFT )

    self.CloseButton = vgui.Create( "DButton", self )
    self.CloseButton:SetText( "" )
    self.CloseButton:Dock( RIGHT )
    self.CloseButton.DoClick = GlorifiedLeveling.UI.ClosePerkMenu
end

function PANEL:PerformLayout( w, h )
    self.CloseButton:SetSize( w * 0.085, h )
    self.CloseButton.Paint = function( closeButton, closeButtonW, closeButtonH )
        local iconSize = closeButtonH * 0.4
        if not closeButton.Color then closeButton.Color = self.Theme.Data.Colors.perkMenuCloseButtonBackgroundColor end
        closeButton.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 5, closeButton.Color, closeButton:IsHovered() and self.Theme.Data.Colors.perkMenuCloseButtonHoverColor or self.Theme.Data.Colors.perkMenuCloseButtonBackgroundColor )
        surface.SetDrawColor( closeButton.Color )
        surface.SetMaterial( self.Theme.Data.Materials.close )
        surface.DrawTexturedRect( closeButtonW / 2 - iconSize / 2, closeButtonH / 2 - iconSize / 2, iconSize, iconSize )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBoxEx( 6, 0, 0, w, h, self.Theme.Data.Colors.perkMenuTitleBarBackgroundColor, true, true, false, false )
end

vgui.Register( "GlorifiedLeveling.PerkMenu.TitleBar", PANEL, "Panel" )