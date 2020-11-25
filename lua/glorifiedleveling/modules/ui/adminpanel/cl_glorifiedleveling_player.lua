
local PANEL = {}

function PANEL:AddPlayer( ply, level )
    self.Player = ply
    self.Level = level

    self.Avatar = vgui.Create( "GlorifiedLeveling.CircleAvatar", self )

    self.SetLevel = vgui.Create( "DButton", self )
    self.SetLevel:SetText( "" )
    self.SetLevel.Color = Color( 255, 255, 255 )
    self.SetLevel.Paint = function( s, w, h )
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 10, s.Color, s:IsHovered() and self.Theme.Data.Colors.playersMenuSetButtonBackgroundHoverCol or self.Theme.Data.Colors.playersMenuSetButtonBackgroundCol )

        draw.RoundedBox( h * 0.22, 0, 0, w, h, s.Color )
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glSetLevel" ), "GlorifiedLeveling.AdminMenu.PlayerSetLevel", w / 2, h / 2, self.Theme.Data.Colors.playersMenuButtonTextCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end
    self.SetLevel.DoClick = function( s )
        if IsValid( GlorifiedLeveling.UI.SetLevelConfirmation ) then return end

        GlorifiedLeveling.UI.SetLevelConfirmation = vgui.Create( "GlorifiedLeveling.SetLevelConfirmation" )
        GlorifiedLeveling.UI.SetLevelConfirmation.SteamID = self.Player:SteamID()
    end

    self.ResetLevel = vgui.Create( "DButton", self )
    self.ResetLevel:SetText( "" )
    self.ResetLevel.Color = Color( 255, 255, 255 )
    self.ResetLevel.Paint = function( s, w, h )
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 10, s.Color, s:IsHovered() and self.Theme.Data.Colors.playersMenuResetButtonBackgroundHoverCol or self.Theme.Data.Colors.playersMenuResetButtonBackgroundCol )

        draw.RoundedBox( h * 0.22, 0, 0, w, h, s.Color )
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glResetLevel" ), "GlorifiedLeveling.AdminMenu.PlayerSetLevel", w / 2, h / 2, self.Theme.Data.Colors.playersMenuButtonTextCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end
    self.ResetLevel.DoClick = function( s )
        if IsValid( GlorifiedLeveling.UI.ResetLevelConfirmation ) then return end

        GlorifiedLeveling.UI.ResetLevelConfirmation = vgui.Create( "GlorifiedLeveling.ResetLevelConfirmation" )
        GlorifiedLeveling.UI.ResetLevelConfirmation.SteamID = self.Player:SteamID()
    end

    self.AddXP = vgui.Create( "DButton", self )
    self.AddXP:SetText( "" )
    self.AddXP.Color = Color( 255, 255, 255 )
    self.AddXP.Paint = function( s, w, h )
        s.Color = GlorifiedLeveling.UI.LerpColor( FrameTime() * 10, s.Color, s:IsHovered() and self.Theme.Data.Colors.playersMenuAddButtonBackgroundCol or self.Theme.Data.Colors.playersMenuAddButtonBackgroundHoverCol )

        draw.RoundedBox( h * 0.22, 0, 0, w, h, s.Color )
        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glAddXP" ), "GlorifiedLeveling.AdminMenu.PlayerSetLevel", w / 2, h / 2, self.Theme.Data.Colors.playersMenuButtonTextCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end
    self.AddXP.DoClick = function(s)
        if IsValid( GlorifiedLeveling.UI.AddXPConfirmation ) then return end

        GlorifiedLeveling.UI.AddXPConfirmation = vgui.Create( "GlorifiedLeveling.AddXPConfirmation" )
        GlorifiedLeveling.UI.AddXPConfirmation.SteamID = self.Player:SteamID()
    end

    local function drawPlayerInfo( playerno, x, containerh, align )
        local centerh = containerh / 2
        local spacing = containerh * 0.1
        local wSpacing = containerh * 0.25

        draw.SimpleText( self.Player:Name(), "GlorifiedLeveling.AdminMenu.PlayerInfo", x + wSpacing, centerh - spacing, self.Theme.Data.Colors.playerNameTextCol, align, TEXT_ALIGN_CENTER )
        draw.SimpleText( self.Player:SteamID(), "GlorifiedLeveling.AdminMenu.PlayerInfo", x + wSpacing, centerh + spacing, self.Theme.Data.Colors.playerSteamIDTextCol, align, TEXT_ALIGN_CENTER )
    end

    function self:Paint( w, h )
        draw.RoundedBox( h * 0.1, 0, 0, w, h, self.Theme.Data.Colors.playerBackgroundCol )

        drawPlayerInfo( 1, h * 0.77, h, TEXT_ALIGN_LEFT )

        draw.SimpleText( GlorifiedLeveling.i18n.GetPhrase( "glLevelX", self.Level ), "GlorifiedLeveling.AdminMenu.PlayerLevel", w * .95, h / 2, self.Theme.Data.Colors.playerInfoTextCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
    end
end

function PANEL:PerformLayout( w, h )
    local avatarsize = h * 0.65

    self.Avatar:SetSize( avatarsize, avatarsize )
    self.Avatar:SetMaskSize( avatarsize * 0.5 )
    self.Avatar:SetPos( h * 0.25, h * 0.18 )
    self.Avatar:SetSteamID( self.Player:SteamID64(), avatarsize )

    self.SetLevel:SetSize( w * 0.12, h * 0.4 )
    self.SetLevel:SetPos( w * 0.3, h * 0.3 )

    self.ResetLevel:SetSize( w * 0.14, h * 0.4 )
    self.ResetLevel:SetPos( w * 0.43, h * 0.3 )

    self.AddXP:SetSize( w * 0.13, h * 0.4 )
    self.AddXP:SetPos( w * 0.58, h * 0.3 )

    if not self.CanEditPlayers then
        self.SetLevel:SetVisible( false )
        self.ResetLevel:SetVisible( false )
        self.AddXP:SetVisible( false )
    end
end

vgui.Register( "GlorifiedLeveling.Player", PANEL, "Panel" )