

local PANEL = {}

function PANEL:Init()
    self:SetSize( ScrH() * 0.4, ScrH() * 0.18 )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedLeveling.Themes.GetCurrent()

    self.Close = vgui.Create( "DButton", self )
    self.Close:SetText( "" )

    self.Close.DoClick = function( s )
        self:Remove()
    end

    self.Close.Color = Color( 255, 255, 255 )
    self.Close.Paint = function(s, w, h)
        local iconSize = h * 0.5

        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 5, s.Color, s:IsHovered() and self.Theme.Data.Colors.adminMenuCloseButtonHoverCol or self.Theme.Data.Colors.adminMenuCloseButtonCol )

        surface.SetDrawColor( s.Color )
        surface.SetMaterial( self.Theme.Data.Materials.close )
        surface.DrawTexturedRect( w / 2 - iconSize / 2, h / 2 - iconSize / 2, iconSize, iconSize )
    end

    self.Yes = vgui.Create( "DButton", self )
    self.Yes:SetText("")

    self.Yes.Color = Color(255, 255, 255)
    self.Yes.Paint = function(s, w, h)
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 10, s.Color, s:IsHovered() and self.Theme.Data.Colors.resetLevelYesButtonBackgroundHoverCol or self.Theme.Data.Colors.resetLevelYesButtonBackgroundCol )

        draw.RoundedBox( h * 0.1, 0, 0, w, h, s.Color )
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glYes" ), "GlorifiedLeveling.AdminMenu.SetLevelButton", w / 2, h * .43, self.Theme.Data.Colors.setLevelButtonTextCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    self.Yes.DoClick = function(s)
        if not self.SteamID then return end

        net.Start( "GlorifiedLeveling.AdminPanel.ResetPlayerLevel" )
         net.WriteString( self.SteamID )
        net.SendToServer()

        net.Start( "GlorifiedLeveling.AdminPanel.PlayerListOpened" )
        net.SendToServer()

        self:Remove()
    end

    self.No = vgui.Create( "DButton", self )
    self.No:SetText( "" )

    self.No.Color = Color( 255, 255, 255 )
    self.No.Paint = function( s, w, h )
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 10, s.Color, s:IsHovered() and self.Theme.Data.Colors.resetLevelNoButtonBackgroundHoverCol or self.Theme.Data.Colors.resetLevelNoButtonBackgroundCol )

        draw.RoundedBox( h * .1, 0, 0, w, h, s.Color )
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glNo" ), "GlorifiedLeveling.AdminMenu.SetLevelButton", w / 2, h * .43, self.Theme.Data.Colors.setLevelButtonTextCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    self.No.DoClick = function(s)
        self:Remove()
    end

    timer.Simple( 0, function()
        if self.Username then return end
        steamworks.RequestPlayerInfo( self.SteamID, function( name )
            self.Username = name
        end )
    end )
end

function PANEL:PerformLayout( w, h )
    self.Close:SetSize( h * 0.18, h * 0.18 )
    self.Close:SetPos( w - h * 0.18, 0 )

    self.Yes:SetSize( w * 0.95, h * 0.2)
    self.Yes:SetPos( w * 0.025, h * 0.5)

    self.No:SetSize( w * 0.95, h * 0.2 )
    self.No:SetPos( w * 0.025, h * 0.73 )
end

function PANEL:Think()
    self:MoveToFront()
end

function PANEL:Paint(w, h)
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.adminMenuBackgroundCol )
    draw.RoundedBoxEx( 6, 0, 0, w, h * 0.18, self.Theme.Data.Colors.adminMenuNavbarBackgroundCol, true, true )

    draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glConfirmation" ), "GlorifiedLeveling.AdminMenu.SetLevelTitle", w * 0.021, h * 0.08, self.Theme.Data.Colors.adminMenuNavbarItemCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.DrawText( GlorifiedLeveling.i18n.GetPhrase( "glConfirmationResetLevel", self.Username and self.Username or self.SteamID or "undefined" ), "GlorifiedLeveling.AdminMenu.SetLevelDescription", w * 0.021, h * 0.23, self.Theme.Data.Colors.adminMenuNavbarItemCol )
end

vgui.Register( "GlorifiedLeveling.ResetLevelConfirmation", PANEL, "EditablePanel" )