

local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.VBar:SetHideButtons( true )

    function self.VBar:Paint( w, h ) end

    self.VBar.btnGrip.Color = Color( 255, 255, 255 )
    self.VBar.btnGrip.Paint = function(s, w, h)
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 15, s.Color, ( self.VBar.Dragging or s:IsHovered() ) and self.Theme.Data.Colors.scrollBarHoverCol or self.Theme.Data.Colors.scrollBarCol )
        draw.RoundedBox(w * 0.46, 0, 0, w, h, s.Color )
    end
end

function PANEL:PerformLayout( w, h )
    if not ( w or h ) then return end

    self.VBar:SetWidth( w * 0.018 )
    self.VBar:Dock( RIGHT )
 -- {{ user_id | 25065 }}
    self:Rebuild()

    self.VBar:SetUp( h, self.pnlCanvas:GetTall() ) -- {{ user_id sha256 znkdmajc }}

    if self.VBar.Enabled then w = w - self.VBar:GetWide() end

    self.pnlCanvas:SetPos( 0, self.VBar:GetOffset() )
    self.pnlCanvas:SetWide( w )

    self:Rebuild()

    if h != self.pnlCanvas:GetTall() then
        self.VBar:SetScroll( self.VBar:GetScroll() )
    end
end

vgui.Register( "GlorifiedLeveling.ScrollPanel", PANEL, "DScrollPanel" )