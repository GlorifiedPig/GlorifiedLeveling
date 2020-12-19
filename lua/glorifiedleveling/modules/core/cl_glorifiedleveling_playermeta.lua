
local defaultPerkTbl = GlorifiedLeveling.Perks.Enum.DEFAULT_PERK_TABLE

GlorifiedLeveling.PerkTable = defaultPerkTbl
GlorifiedLeveling.PerkTableCache = nil

net.Receive( "GlorifiedLeveling.Perks.SendPerkTableToClient", function()
    GlorifiedLeveling.PerkTable = net.ReadTableAsString() or defaultPerkTbl
end )

net.Receive( "GlorifiedLeveling.PlayerLeveledUp", function()
    hook.Run( "GlorifiedLeveling.LevelUp", net.ReadEntity() )
end )

net.Receive( "GlorifiedLeveling.PlayerXPUpdated", function()
    hook.Run( "GlorifiedLeveling.XPUpdated", net.ReadEntity(), net.ReadUInt( 64 ), net.ReadUInt( 64 ) )
end )

function GlorifiedLeveling.GetPlayerLevel( ply )
    if not ply then ply = LocalPlayer() end
    return ply:GetNWInt( "GlorifiedLeveling.Level" )
end

function GlorifiedLeveling.PlayerHasLevel( ply, level )
    if not ply then ply = LocalPlayer() end
    return GlorifiedLeveling.GetPlayerLevel() >= level
end

function GlorifiedLeveling.GetPlayerXP( ply )
    if not ply then ply = LocalPlayer() end
    return ply:GetNWInt( "GlorifiedLeveling.XP" )
end

function GlorifiedLeveling.GetPlayerMaxXP( ply )
    if not ply then ply = LocalPlayer() end
    local level = GlorifiedLeveling.GetPlayerLevel( ply )
    return ( 100 + ( level * ( level + 1 ) * 75 ) ) * GlorifiedLeveling.Config.MAX_XP_MULTIPLIER
end

function GlorifiedLeveling.GetPlayerPerkTable()
    return GlorifiedLeveling.PerkTable or defaultPerkTbl
end

function GlorifiedLeveling.GetPlayerPerkLevel( perk )
    return GlorifiedLeveling.GetPlayerPerkTable()[perk] or 0
end

function GlorifiedLeveling.GetTotalPerkPoints()
    return math.Round( math.floor( GlorifiedLeveling.GetPlayerLevel() / GlorifiedLeveling.Config.LEVELS_UNTIL_GAIN ) * GlorifiedLeveling.Config.POINTS_PER_GAIN )
end

function GlorifiedLeveling.GetTotalFreePerkPoints( fromCache )
    local totalPoints = GlorifiedLeveling.GetTotalPerkPoints()
    local freePoints = totalPoints
    for k, v in ipairs( fromCache and ( GlorifiedLeveling.PerkTableCache or GlorifiedLeveling.GetPlayerPerkTable() ) or GlorifiedLeveling.GetPlayerPerkTable() ) do
        freePoints = freePoints - v
    end
    return math.max( freePoints, 0 )
end

net.Receive( "GlorifiedLeveling.CacheTopTen", function()
    GlorifiedLeveling.TopTen = net.ReadTableAsString()
end )