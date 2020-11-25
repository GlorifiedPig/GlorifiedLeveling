
util.AddNetworkString( "GlorifiedLeveling.PlayerLeveledUp" )
util.AddNetworkString( "GlorifiedLeveling.CacheTopTen" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.OpenAdminPanel" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.SetLockdownStatus" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.SetPlayerLevel" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.ResetPlayerLevel" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.AddPlayerXP" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.PlayerListOpened" )
util.AddNetworkString( "GlorifiedLeveling.AdminPanel.PlayerListOpened.SendInfo" )
util.AddNetworkString( "GlorifiedLeveling.Perks.UpdatePerkInfo" )
util.AddNetworkString( "GlorifiedLeveling.Perks.SendPerkTableToClient" )

hook.Add( "GlorifiedLeveling.LevelUp", "GlorifiedLeveling.Networking.LevelUp", function( ply )
    net.Start( "GlorifiedLeveling.PlayerLeveledUp" )
    net.WriteEntity( ply )
    net.Broadcast()
end )

function GlorifiedLeveling.CacheTopTenOnClient( ply )
    net.Start( "GlorifiedLeveling.CacheTopTen" )
    net.WriteTableAsString( GlorifiedLeveling.TopTen )
    net.Send( ply )
end

hook.Add( "PlayerInitialSpawn", "GlorifiedLeveling.Networking.PlayerSpawn.CacheTopTen", GlorifiedLeveling.CacheTopTenOnClient )

net.Receive( "GlorifiedLeveling.AdminPanel.SetLockdownStatus", function( len, ply )
    if GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_togglelockdown" ) then
        GlorifiedLeveling.SetLockdownEnabled( net.ReadBool() )
    end
end )

net.Receive( "GlorifiedLeveling.AdminPanel.SetPlayerLevel", function( len, ply )
    if GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_manipulateplayerlevel" ) then
        local plyFromSteamID = player.GetBySteamID( net.ReadString() )
        if not plyFromSteamID then return end
        local newLevel = net.ReadUInt( 32 )
        if newLevel < GlorifiedLeveling.GetPlayerLevel( plyFromSteamID ) then
            GlorifiedLeveling.ResetPlayerPerks( plyFromSteamID ) -- Always reset the perks first if the new level is lower than the original one.
        end
        GlorifiedLeveling.SetPlayerXP( plyFromSteamID, 0 )
        GlorifiedLeveling.SetPlayerLevel( plyFromSteamID, newLevel )
    end
end )

net.Receive( "GlorifiedLeveling.AdminPanel.ResetPlayerLevel", function( len, ply )
    if GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_manipulateplayerlevel" ) then
        local plyFromSteamID = player.GetBySteamID( net.ReadString() )
        if not plyFromSteamID then return end
        GlorifiedLeveling.ResetPlayerPerks( plyFromSteamID )
        GlorifiedLeveling.SetPlayerXP( plyFromSteamID, 0 )
        GlorifiedLeveling.SetPlayerLevel( plyFromSteamID, 1 )
    end
end )

net.Receive( "GlorifiedLeveling.AdminPanel.AddPlayerXP", function( len, ply )
    if GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_manipulateplayerlevel" ) then
        local plyFromSteamID = player.GetBySteamID( net.ReadString() )
        local xpToAdd = net.ReadUInt( 32 )
        GlorifiedLeveling.AddPlayerXP( plyFromSteamID, xpToAdd, true )
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

local resetDelayIdentifier = "GlorifiedLeveling.NetUpdatePerkInfo.ResetDelay"
hook.Add( "PlayerSpawn", "GlorifiedLeveling.NetUpdatePerkInfo.PlayerSpawn", function( ply )
    ply:GlorifiedLeveling().AwaitingPerkUpdate = true

    if timer.Exists( resetDelayIdentifier ) then
        timer.Start( resetDelayIdentifier )
    else
        timer.Create( resetDelayIdentifier, 5, 1, function()
            if ply then ply:GlorifiedLeveling().AwaitingPerkUpdate = nil end
        end )
    end
end )

net.Receive( "GlorifiedLeveling.Perks.UpdatePerkInfo", function( len, ply )
    if not ply:GlorifiedLeveling().AwaitingPerkUpdate then return end
    ply:GlorifiedLeveling().AwaitingPerkUpdate = nil
    local newPerkTbl = util.JSONToTable( net.ReadString() )
    if GlorifiedLeveling.GetTotalLevelsFromPerkTable( newPerkTbl ) > GlorifiedLeveling.GetTotalPerkPoints( ply ) then return end
    GlorifiedLeveling.SetPlayerPerkTable( ply, newPerkTbl )
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