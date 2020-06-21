
local PANEL = {}

function PANEL:Init()
    self:SetSize( ScrH() * 0.5, ScrH() * 0.2 )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedLeveling.Themes.GetCurrent()

    self.Close = vgui.Create("DButton", self)
    self.Close:SetText("")

    self.Close.DoClick = function(s)
        self:Remove()
    end

    self.Close.Color = Color( 255, 255, 255 )
    self.Close.Paint = function( s, w, h )
        local iconSize = h * .5

        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 5, s.Color, s:IsHovered() and self.Theme.Data.Colors.adminMenuCloseButtonHoverCol or self.Theme.Data.Colors.adminMenuCloseButtonCol )

        surface.SetDrawColor( s.Color )
        surface.SetMaterial( self.Theme.Data.Materials.close )
        surface.DrawTexturedRect( w / 2 - iconSize / 2, h / 2 - iconSize / 2, iconSize, iconSize )
    end

    self.Entry = vgui.Create( "DTextEntry", self )
    self.Entry:SetValue( "0" )
    self.Entry:SetFont( "GlorifiedLeveling.AdminMenu.SetLevelEntry" )
    self.Entry:SetNumeric( true )

    self.Enter = vgui.Create( "DButton", self )
    self.Enter:SetText("")

    self.Enter.Color = Color( 255, 255, 255 )
    self.Enter.Paint = function( s, w, h )
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 10, s.Color, s:IsHovered() and self.Theme.Data.Colors.setLevelButtonBackgroundHoverCol or self.Theme.Data.Colors.setLevelButtonBackgroundCol )

        draw.RoundedBox( h * 0.1, 0, 0, w, h, s.Color )
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glEnter" ), "GlorifiedLeveling.AdminMenu.SetLevelButton", w / 2, h * .43, self.Theme.Data.Colors.setLevelButtonTextCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    self.Enter.DoClick = function( s )
        if not self.SteamID then return end
        if tonumber( self.Entry:GetValue() ) < 0 or tonumber( self.Entry:GetValue() ) > GlorifiedLeveling.Config.MAX_LEVEL then
            GlorifiedLeveling.Notify( NOTIFY_ERROR, 3, GlorifiedLeveling.i18n.GetPhrase( "glInvalidAmount" ) )
            return
        end

        net.Start("GlorifiedLeveling.AdminPanel.SetPlayerLevel")
         net.WriteString( self.SteamID )
         net.WriteUInt( self.Entry:GetValue(), 32 )
        net.SendToServer()

        net.Start("GlorifiedLeveling.AdminPanel.PlayerListOpened")
        net.SendToServer()

        self:Remove()
    end

    timer.Simple(0, function()
        if self.Username then return end
        steamworks.RequestPlayerInfo(self.SteamID, function(name)
            self.Username = name
        end)
    end)
end

function PANEL:PerformLayout( w, h )
    self.Close:SetSize( h * 0.18, h * 0.18 )
    self.Close:SetPos( w - h * 0.18, 0 )

    self.Entry:SetSize( w * 0.95, h * 0.2 )
    self.Entry:SetPos( w * 0.025, h * 0.4)

    self.Enter:SetSize( w * 0.95, h * 0.2)
    self.Enter:SetPos( w * 0.025, h * 0.73)
end

function PANEL:Think()
    self:MoveToFront()
end

function PANEL:Paint(w, h)
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.adminMenuBackgroundCol )
    draw.RoundedBoxEx( 6, 0, 0, w, h * .18, self.Theme.Data.Colors.adminMenuNavbarBackgroundCol, true, true )

    draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glSetLevel" ), "GlorifiedLeveling.AdminMenu.SetLevelTitle", w * .021, h * .08, self.Theme.Data.Colors.adminMenuNavbarItemCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glEnterLevel", self.Username and self.Username or self.SteamID or "undefined" ), "GlorifiedLeveling.AdminMenu.SetLevelDescription", w * 0.021, h * 0.23, self.Theme.Data.Colors.adminMenuNavbarItemCol )
end

vgui.Register( "GlorifiedLeveling.SetLevelConfirmation", PANEL, "EditablePanel" )