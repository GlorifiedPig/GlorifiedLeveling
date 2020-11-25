
local defaultPerkTbl = GlorifiedLeveling.Perks.Enum.DEFAULT_PERK_TABLE

GlorifiedLeveling.PerkTable = defaultPerkTbl
GlorifiedLeveling.PerkTableCache = nil

local ply

net.Receive( "GlorifiedLeveling.Perks.SendPerkTableToClient", function()
    GlorifiedLeveling.PerkTable = net.ReadTableAsString() or defaultPerkTbl
end )

function GlorifiedLeveling.GetPlayerLevel()
    if not ply then ply = LocalPlayer() end
    return ply:GetNW2Int( "GlorifiedLeveling.Level" )
end

function GlorifiedLeveling.PlayerHasLevel( level )
    return GlorifiedLeveling.GetPlayerLevel() >= level
end

function GlorifiedLeveling.GetPlayerXP()
    if not ply then ply = LocalPlayer() end
    return ply:GetNW2Int( "GlorifiedLeveling.XP" )
end

function GlorifiedLeveling.GetPlayerMaxXP()
    local level = GlorifiedLeveling.GetPlayerLevel()
    return ( 100 + ( level * ( level + 1 ) * 75 ) ) * GlorifiedLeveling.Config.MAX_XP_MULTIPLIER
end

function GlorifiedLeveling.GetPlayerPerkTable()
    if not ply then ply = LocalPlayer() end

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