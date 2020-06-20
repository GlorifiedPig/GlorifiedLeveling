
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.OpenAdminPanel" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.SetLockdownStatus" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.PlayerListOpened" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.PlayerListOpened.SendInfo" )

net.Receive( "GlorifiedLeveling.AdminPanel.SetLockdownStatus", function( len, ply )
    if GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_togglelockdown" ) then
        GlorifiedLeveling.SetLockdownEnabled( net.ReadBool() )
    end
end )

net.Receive( "GlorifiedLeveling.AdminPanel.PlayerListOpened", function( len, ply )
    if GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_openadminpanel" ) then
        local playerList = {}
        for k, v in ipairs( player.GetAll() ) do
            playerList[v:SteamID()] = GlorifiedLeveling.GetPlayerLevel( v )
        end

        net.Start( "GlorifiedLeveling.AdminPanel.PlayerListOpened.SendInfo" )
        net.WriteLargeString( util.TableToJSON( playerList ) )
        net.Send( ply )
    end
end )

concommand.Add( "glorifiedleveling_admin", function( ply )
    if not IsValid( ply ) then return end
    if GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_openadminpanel" ) then
        net.Start( "GlorifiedLeveling.AdminPanel.OpenAdminPanel" )
        net.WriteBool( GlorifiedLeveling.LockdownEnabled )
        net.WriteBool( GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_manipulateplayerlevel" ) )
        net.Send( ply )
    end
end )