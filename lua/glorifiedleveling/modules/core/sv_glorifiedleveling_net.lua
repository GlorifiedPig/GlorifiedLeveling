
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.OpenAdminPanel" )

concommand.Add( "glorifiedleveling_admin", function( ply )
    if not IsValid( ply ) then return end
    if GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_openadminpanel" ) then
        net.Start( "GlorifiedLeveling.AdminPanel.OpenAdminPanel" )
        net.WriteBool( GlorifiedLeveling.LockdownEnabled )
        net.WriteBool( GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_manipulateplayerlevel" ) )
        net.Send( ply )
    end
end )