
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme
    self.Progress = 0
    self.AddButton = vgui.Create( "DButton", self )
    self.RemoveButton = vgui.Create( "DButton", self )
end

function PANEL:PerformLayout( w, h )
    local parent = self:GetParent()
    local themeColors = self.Theme.Data.Colors

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
        self.AddButton:SetTextColor( self.AddButton:IsHovered() and themeColors.perkMenuEntryAddButtonColorHovered or themeColors.perkMenuEntryAddButtonColor )
    end
    self.AddButton.DoClick = function()
        if parent.CachedFreePoints <= 0 then return end
        self.Progress = math.Clamp( self.Progress + 1, 0, 10 )
        self.AddButton:SetVisible( self.Progress < 10 )
        self.RemoveButton:SetVisible( self.Progress > 0 )
        GlorifiedLeveling.PerkTableCache[self.Perk] = GlorifiedLeveling.PerkTableCache[self.Perk] + 1
        parent.CachedFreePoints = parent.CachedFreePoints - 1
        parent.TitleBar.FreePointsLabel.FreePointsChanged()
    end
    self.AddButton.Paint = function() end

    self.RemoveButton:SetSize( self.SliderBoxH, self.SliderBoxH )
    self.RemoveButton:SetPos( self.SliderBoxX - self.SliderBoxH - ( self.SliderBoxW / 80 ), self.SliderBoxY )
    self.RemoveButton:SetFont( "GlorifiedLeveling.PerkMenu.PerkModifyText" )
    self.RemoveButton:SetText( "-" )
    self.RemoveButton:SetVisible( self.Progress > 0 )
    self.RemoveButton.Think = function()
        self.RemoveButton:SetTextColor( self.RemoveButton:IsHovered() and themeColors.perkMenuEntryRemoveButtonColorHovered or themeColors.perkMenuEntryRemoveButtonColor )
    end
    self.RemoveButton.DoClick = function()
        self.Progress = math.Clamp( self.Progress - 1, 0, 10 )
        self.AddButton:SetVisible( self.Progress < 10 )
        self.RemoveButton:SetVisible( self.Progress > 0 )
        GlorifiedLeveling.PerkTableCache[self.Perk] = GlorifiedLeveling.PerkTableCache[self.Perk] - 1
        parent.CachedFreePoints = parent.CachedFreePoints + 1
        parent.TitleBar.FreePointsLabel.FreePointsChanged()
    end
    self.RemoveButton.Paint = function() end

    self.LayoutInitialized = true
end

function PANEL:SetPerk( perk )
    self.Perk = perk
    self.Progress = GlorifiedLeveling.PerkTableCache[perk]
end

function PANEL:Paint( w, h )
    local themeColors = self.Theme.Data.Colors
    draw.RoundedBox( 8, 0, 0, w, h, themeColors.perkMenuEntryBackgroundColor )
    if not self.Perk or not self.LayoutInitialized then return end
    local perkInfo = GlorifiedLeveling.Perks.PERK_INFO[self.Perk]

    draw.SimpleText( perkInfo.Name, "GlorifiedLeveling.PerkMenu.PerkText", self.SideOffset, h / 2 - h / 8, themeColors.perkMenuEntryPerkName, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.SimpleText( perkInfo.Description, "GlorifiedLeveling.PerkMenu.PerkDescriptionText", self.SideOffset + 1, h / 2 + h / 7, themeColors.perkMenuEntryPerkDescription, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    draw.RoundedBox( 8, self.SliderBoxX, self.SliderBoxY, self.SliderBoxW, self.SliderBoxH, themeColors.perkMenuEntrySliderBackgroundColor )

    if self.Progress < 10 then
        local progressW = ( self.SliderBoxW / 10 ) * self.Progress
        render.SetScissorRect( self.SliderBoxX, 0, self:LocalToScreen( self.SliderBoxX ) + progressW, ScrH(), true )
        draw.RoundedBox( 8, self.SliderBoxX, self.SliderBoxY, self.SliderBoxW, self.SliderBoxH, themeColors.perkMenuEntrySliderProgressedColor )
        render.SetScissorRect( 0, 0, ScrW(), ScrH(), false )

        for i = 1, 9 do
            draw.RoundedBox( 0, self.SliderBoxX + ( ( self.SliderBoxW / 10 ) * i ) - 1, self.SliderBoxY, 1, self.SliderBoxH, themeColors.perkMenuEntrySliderLiningColor )
        end
    else
        draw.RoundedBox( 8, self.SliderBoxX, self.SliderBoxY, self.SliderBoxW, self.SliderBoxH, themeColors.perkMenuEntrySliderProgressedColor )
        draw.SimpleText( "Complete", "GlorifiedLeveling.PerkMenu.PerkCompleteText", self.SliderBoxX + ( self.SliderBoxW / 2 ), self.SliderBoxY + ( self.SliderBoxH / 2 ) - 1, themeColors.perkMenuEntrySliderTexts, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end
    draw.SimpleText( "(" .. self.Progress .. "/10)", "GlorifiedLeveling.PerkMenu.PerkAmountText", self.SliderBoxX + ( self.SliderBoxW / 2 ), self.SliderBoxY + self.SliderBoxH + ( self.SliderBoxH / 2.5 ), themeColors.perkMenuEntrySliderTexts, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

vgui.Register( "GlorifiedLeveling.PerkMenu.PerkEntry", PANEL, "EditablePanel" )