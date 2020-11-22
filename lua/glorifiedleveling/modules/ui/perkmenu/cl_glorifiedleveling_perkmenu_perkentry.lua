
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

    local sideOffset = w / 50

    draw.SimpleText( perkInfo.Name, "GlorifiedLeveling.PerkMenu.PerkText", sideOffset, h / 2 - h / 8, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.SimpleText( perkInfo.Description, "GlorifiedLeveling.PerkMenu.PerkDescriptionText", sideOffset, h / 2 + h / 7, Color( 155, 155, 155 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    local boxH = h / 3.2
    local boxW = w / 2.5
    local boxX = w - boxW - sideOffset - ( boxW / 10 )
    local boxY = ( h / 2 ) - ( boxH / 2 )
    draw.RoundedBox( 8, boxX, boxY, boxW, boxH, Color( 51, 51, 51 ) )

    local progress = 10
    if progress < 10 then
        local progressW = ( boxW / 10 ) * progress
        render.SetScissorRect( boxX, 0, self:LocalToScreen( boxX ) + progressW, ScrH(), true )
        draw.RoundedBox( 8, boxX, boxY, boxW, boxH, Color( 89, 175, 63 ) )
        render.SetScissorRect( 0, 0, ScrW(), ScrH(), false )

        for i = 1, 9 do
            draw.RoundedBox( 0, boxX + ( ( boxW / 10 ) * i ) - 1, boxY, 1, boxH, Color( 0, 0, 0, 185 ) )
        end
    else
        draw.RoundedBox( 8, boxX, boxY, boxW, boxH, Color( 89, 175, 63 ) )
        draw.SimpleText( "Complete", "GlorifiedLeveling.PerkMenu.PerkCompleteText", boxX + ( boxW / 2 ), boxY + ( boxH / 2 ) - 1, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end
    draw.SimpleText( "(" .. progress .. "/10)", "GlorifiedLeveling.PerkMenu.PerkAmountText", boxX + ( boxW / 2 ), boxY + boxH + ( boxH / 2.5 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    draw.RoundedBox( 0, boxX - boxH - ( boxW / 80 ), boxY, boxH, boxH, Color( 175, 68, 63 ) )
    draw.RoundedBox( 0, boxX + boxW + ( boxW / 80 ) + 1, boxY, boxH, boxH, Color( 0, 155, 0 ) )
end

vgui.Register( "GlorifiedLeveling.PerkMenu.PerkEntry", PANEL, "EditablePanel" )