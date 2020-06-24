 -- {{ user_id | 74881 }}
local PANEL = {}

function PANEL:Init()
    self:SetSize( ScrH() * 0.746, ScrH() * 0.8 )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedLeveling.Themes.GetCurrent()

    self.Navbar = vgui.Create( "GlorifiedBanking.AdminNavbar", self )

    local function changePage( page )
        if not IsValid( self.Page ) then
            self.Page = vgui.Create( page, self )
            self.Page:Dock( FILL )
            self.Page.CanEditPlayers = self.CanEditPlayers
            return
        end

        self.Page:AlphaTo( 0, 0.15, 0, function( anim, panel )
            self.Page:Remove()

            self.Page = vgui.Create( page, self )
            self.Page:Dock( FILL )
            self.Page:SetAlpha( 0 )
            self.Page:AlphaTo( 255, 0.15 )
            self.Page.CanEditPlayers = self.CanEditPlayers
        end )
    end

    self.Navbar:AddItem( GlorifiedLeveling.i18n.GetPhrase( "glAdminMenuPlayers" ), LEFT, function( s ) changePage( "GlorifiedLeveling.Players" ) end )

    self.Navbar:AddItem( "LOCK", LEFT, function( s )
        self.LockdownMode = not self.LockdownMode

        net.Start( "GlorifiedLeveling.AdminPanel.SetLockdownStatus" )
         net.WriteBool( self.LockdownMode )
        net.SendToServer()
    end )

    self.Navbar:AddItem( "X", RIGHT, function( s )
        self:AlphaTo( 0, 0.3, 0, function( anim, panel )
            panel:Remove()
        end)
    end )

    self.Navbar:SelectTab( 1 ) -- {{ user_id sha256 ttjqriko }}
    timer.Simple( 0, function()
        changePage( "GlorifiedLeveling.Players" )
    end )

    self:SetAlpha( 0 )
    self:AlphaTo( 255, 0.3 )
end

function PANEL:PerformLayout( w, h )
    self.Navbar:Dock( TOP )
    self.Navbar:SetSize( w, h * 0.06 )

    if IsValid( self.Page ) then
        self.Page:Dock( FILL )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.adminMenuBackgroundCol )
end

vgui.Register( "GlorifiedLeveling.AdminMenu", PANEL, "EditablePanel" )

function GlorifiedLeveling.UI.OpenAdminMenu( lockdownEnabled, canEditPlayers )
    if not IsValid( LocalPlayer() ) then return end

    if IsValid( GlorifiedLeveling.UI.AdminMenu ) then
        GlorifiedLeveling.UI.AdminMenu:Remove()
        GlorifiedLeveling.UI.AdminMenu = nil
    end

    GlorifiedLeveling.UI.AdminMenu = vgui.Create( "GlorifiedLeveling.AdminMenu" )
    GlorifiedLeveling.UI.AdminMenu.LockdownMode = lockdownEnabled
    GlorifiedLeveling.UI.AdminMenu.CanEditPlayers = canEditPlayers
end

net.Receive( "GlorifiedLeveling.AdminPanel.OpenAdminPanel", function()
    GlorifiedLeveling.UI.OpenAdminMenu( net.ReadBool(), net.ReadBool() )
end )