
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme
end

function PANEL:SetPerk( perk )
    self.Perk = perk
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 8, 0, 0, w, h, Color( 73, 73, 73 ) )
    if not self.Perk then return end
    local theme = self.Theme
    local perkInfo = GlorifiedLeveling.Perks.PERK_INFO[self.Perk]
    draw.SimpleText( perkInfo.Name, "GlorifiedLeveling.PerkMenu.PerkText", w / 50, h / 2 - h / 7, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.SimpleText( perkInfo.Description, "GlorifiedLeveling.PerkMenu.PerkDescriptionText", w / 50, h / 2 + h / 7, Color( 155, 155, 155 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    draw.RoundedBox( 0, w - 50, h / 2.5, w / 3, h / 2.5, Color( 0, 0, 0 ) )
end

vgui.Register( "GlorifiedLeveling.PerkMenu.PerkEntry", PANEL, "EditablePanel" )