
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme
    self.Progress = math.random( 0, 10 )
    self.AddButton = vgui.Create( "DButton", self )
    self.RemoveButton = vgui.Create( "DButton", self )
end

function PANEL:PerformLayout( w, h )
    self.SideOffset = w / 50
    self.SliderBoxW = w / 2.5
    self.SliderBoxH = h / 3.2
    self.SliderBoxX = w - self.SliderBoxW - self.SideOffset - ( self.SliderBoxW / 10 )
    self.SliderBoxY = ( h / 2 ) - ( self.SliderBoxH / 2 )

    self.AddButton:SetSize( self.SliderBoxH, self.SliderBoxH )
    self.AddButton:SetPos( self.SliderBoxX + self.SliderBoxW + ( self.SliderBoxW / 80 ) + 1, self.SliderBoxY )
    self.AddButton:SetFont( "GlorifiedLeveling.PerkMenu.PerkModifyText" )
    self.AddButton:SetText( "+" )
    self.AddButton:SetVisible( self.Progress < 10 )
    self.AddButton.Think = function()
        self.AddButton:SetTextColor( self.AddButton:IsHovered() and Color( 0, 155, 0 ) or Color( 0, 200, 0 ) )
    end
    self.AddButton.DoClick = function()
        self.Progress = math.Clamp( self.Progress + 1, 0, 10 )
        self.AddButton:SetVisible( self.Progress < 10 )
        self.RemoveButton:SetVisible( self.Progress > 0 )
    end
    self.AddButton.Paint = function() end

    self.RemoveButton:SetSize( self.SliderBoxH, self.SliderBoxH )
    self.RemoveButton:SetPos( self.SliderBoxX - self.SliderBoxH - ( self.SliderBoxW / 80 ), self.SliderBoxY )
    self.RemoveButton:SetFont( "GlorifiedLeveling.PerkMenu.PerkModifyText" )
    self.RemoveButton:SetText( "-" )
    self.RemoveButton:SetVisible( self.Progress > 0 )
    self.RemoveButton.Think = function()
        self.RemoveButton:SetTextColor( self.RemoveButton:IsHovered() and Color( 200, 0, 0 ) or Color( 255, 0, 0 ) )
    end
    self.RemoveButton.DoClick = function()
        self.Progress = math.Clamp( self.Progress - 1, 0, 10 )
        self.AddButton:SetVisible( self.Progress < 10 )
        self.RemoveButton:SetVisible( self.Progress > 0 )
    end
    self.RemoveButton.Paint = function() end

    self.LayoutInitialized = true
end

function PANEL:SetPerk( perk )
    self.Perk = perk
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 8, 0, 0, w, h, Color( 73, 73, 73 ) )
    if not self.Perk or not self.LayoutInitialized then return end
    local theme = self.Theme
    local perkInfo = GlorifiedLeveling.Perks.PERK_INFO[self.Perk]

    draw.SimpleText( perkInfo.Name, "GlorifiedLeveling.PerkMenu.PerkText", self.SideOffset, h / 2 - h / 8, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.SimpleText( perkInfo.Description, "GlorifiedLeveling.PerkMenu.PerkDescriptionText", self.SideOffset + 1, h / 2 + h / 7, Color( 155, 155, 155 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    draw.RoundedBox( 8, self.SliderBoxX, self.SliderBoxY, self.SliderBoxW, self.SliderBoxH, Color( 51, 51, 51 ) )

    if self.Progress < 10 then
        local progressW = ( self.SliderBoxW / 10 ) * self.Progress
        render.SetScissorRect( self.SliderBoxX, 0, self:LocalToScreen( self.SliderBoxX ) + progressW, ScrH(), true )
        draw.RoundedBox( 8, self.SliderBoxX, self.SliderBoxY, self.SliderBoxW, self.SliderBoxH, Color( 89, 175, 63 ) )
        render.SetScissorRect( 0, 0, ScrW(), ScrH(), false )

        for i = 1, 9 do
            draw.RoundedBox( 0, self.SliderBoxX + ( ( self.SliderBoxW / 10 ) * i ) - 1, self.SliderBoxY, 1, self.SliderBoxH, Color( 0, 0, 0, 100 ) )
        end
    else
        draw.RoundedBox( 8, self.SliderBoxX, self.SliderBoxY, self.SliderBoxW, self.SliderBoxH, Color( 89, 175, 63 ) )
        draw.SimpleText( "Complete", "GlorifiedLeveling.PerkMenu.PerkCompleteText", self.SliderBoxX + ( self.SliderBoxW / 2 ), self.SliderBoxY + ( self.SliderBoxH / 2 ) - 1, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end
    draw.SimpleText( "(" .. self.Progress .. "/10)", "GlorifiedLeveling.PerkMenu.PerkAmountText", self.SliderBoxX + ( self.SliderBoxW / 2 ), self.SliderBoxY + self.SliderBoxH + ( self.SliderBoxH / 2.5 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

vgui.Register( "GlorifiedLeveling.PerkMenu.PerkEntry", PANEL, "EditablePanel" )