
local PANEL = {}

function PANEL:AddPlayer( ply, level )
    self.Player = ply
    self.Level = level

    self.Avatar = vgui.Create( "GlorifiedLeveling.CircleAvatar", self )

    self.SetLevel = vgui.Create( "DButton", self )
    self.SetLevel:SetText( "" )
    self.SetLevel.Color = Color( 255, 255, 255 )
    self.SetLevel.Paint = function(s, w, h)
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 10, s.Color, s:IsHovered() and self.Theme.Data.Colors.playersMenuSetButtonBackgroundHoverCol or self.Theme.Data.Colors.playersMenuSetButtonBackgroundCol )

        draw.RoundedBox( h * .22, 0, 0, w, h, s.Color)
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glSetLevel" ), "GlorifiedLeveling.AdminMenu.PlayerSetLevel", w / 2, h / 2, self.Theme.Data.Colors.playersMenuButtonTextCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    self.SetLevel.DoClick = function(s)
        if IsValid( GlorifiedLeveling.UI.SetLevelPopup ) then return end

        GlorifiedLeveling.UI.SetLevelPopup = vgui.Create( "GlorifiedLeveling.SetLevelPopup" )
        GlorifiedLeveling.UI.SetLevelPopup.SteamID = self.Player:SteamID()
    end

    self.ResetLevel = vgui.Create("DButton", self)
    self.ResetLevel:SetText("")
    self.ResetLevel.Color = Color(255, 255, 255)
    self.ResetLevel.Paint = function(s, w, h)
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 10, s.Color, s:IsHovered() and self.Theme.Data.Colors.playersMenuResetButtonBackgroundHoverCol or self.Theme.Data.Colors.playersMenuResetButtonBackgroundCol )

        draw.RoundedBox( h * 0.22, 0, 0, w, h, s.Color )
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase("gbResetLevel"), "GlorifiedLeveling.AdminMenu.PlayerSetLevel", w / 2, h / 2, self.Theme.Data.Colors.playersMenuButtonTextCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    self.ResetLevel.DoClick = function( s )
        if IsValid( GlorifiedLeveling.UI.ConfirmationPopup ) then return end

        GlorifiedLeveling.UI.ConfirmationPopup = vgui.Create( "GlorifiedLeveling.ConfirmationPopup" )
        GlorifiedLeveling.UI.ConfirmationPopup.SteamID = self.Player:SteamID()
    end

    self.AddXP = vgui.Create( "DButton", self )
    self.AddXP:SetText( "" )
    self.AddXP.Color = Color( 255, 255, 255 )
    self.AddXP.Paint = function( s, w, h )
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 10, s.Color, s:IsHovered() and self.Theme.Data.Colors.playersMenuTransactionsButtonBackgroundHoverCol or self.Theme.Data.Colors.playersMenuTransactionsButtonBackgroundCol )

        draw.RoundedBox( h * 0.22, 0, 0, w, h, s.Color )
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glAddXP" ), "GlorifiedLeveling.AdminMenu.PlayerSetLevel", w / 2, h / 2, self.Theme.Data.Colors.playersMenuButtonTextCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    self.AddXP.DoClick = function(s)
        if IsValid( GlorifiedLeveling.UI.AddXPPopup ) then return end

        GlorifiedLeveling.UI.AddXPPopup = vgui.Create( "GlorifiedLeveling.AddXPPopup" )
        GlorifiedLeveling.UI.AddXPPopup.SteamID = self.Player:SteamID()
    end

    local function drawPlayerInfo( playerno, x, containerh, align )
        local centerh = containerh / 2
        local spacing = containerh * .1

        draw.SimpleText( self.Player:Name(), "GlorifiedLeveling.AdminMenu.LogPlayerInfo", x, centerh - spacing, self.Theme.Data.Colors.logsMenuLogPlayerNameTextCol, align, TEXT_ALIGN_CENTER )
        draw.SimpleText( self.Player:SteamID(), "GlorifiedLeveling.AdminMenu.LogPlayerInfo", x, centerh + spacing, self.Theme.Data.Colors.logsMenuLogPlayerSteamIDTextCol, align, TEXT_ALIGN_CENTER )
    end

    function self:Paint( w, h )
        draw.RoundedBox( h * 0.1, 0, 0, w, h, self.Theme.Data.Colors.logsMenuLogBackgroundCol )

        drawPlayerInfo(1, h * 0.77, h, TEXT_ALIGN_LEFT)

        draw.SimpleText( self.Level, "GlorifiedLeveling.AdminMenu.LogLevel", w * .95, h / 2, self.Theme.Data.Colors.logsMenuLogInfoTextCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
    end
end

function PANEL:PerformLayout( w, h )
    local avatarsize = h * 0.65

    self.Avatar:SetSize( avatarsize, avatarsize )
    self.Avatar:SetMaskSize( avatarsize * 0.5 )
    self.Avatar:SetPos( h * 0.08, h * 0.18 )
    self.Avatar:SetSteamID( self.Player:SteamID64(), avatarsize )

    self.SetLevel:SetSize( w * 0.12, h * 0.4 )
    self.SetLevel:SetPos( w * 0.3, h * 0.3 )

    self.ResetLevel:SetSize( w * 0.14, h * 0.4 )
    self.ResetLevel:SetPos( w * 0.43, h * 0.3 )

    if not self.CanEditPlayers then
        self.SetLevel:SetVisible( false )
        self.ResetLevel:SetVisible( false )
    end

    self.AddXP:SetSize( w * 0.13, h * 0.4 )
    self.AddXP:SetPos( w * 0.58, h * 0.3 )
end

vgui.Register( "GlorifiedLeveling.Player", PANEL, "Panel" )