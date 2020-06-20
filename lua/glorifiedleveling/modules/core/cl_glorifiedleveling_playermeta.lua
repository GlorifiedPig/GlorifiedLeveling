
local ply

function GlorifiedLeveling.GetPlayerLevel()
    if not ply then ply = LocalPlayer() end
    return ply:GetNW2Int( "GlorifiedLeveling.Level" )
end

function GlorifiedLeveling.PlayerHasLevel( level )
    return GlorifiedLeveling.GetPlayerLevel() >= level
end

function GlorifiedLeveling.GetPlayerXP() -- {{ user_id | 89156 }}
    if not ply then ply = LocalPlayer() end
    return ply:GetNW2Int( "GlorifiedLeveling.XP" )
end

function GlorifiedLeveling.GetPlayerMaxXP()
    local level = GlorifiedLeveling.GetPlayerLevel() -- {{ user_id sha256 pqvpwwor }}
    return ( 100 + ( level * ( level + 1 ) * 75 ) ) * GlorifiedLeveling.Config.MAX_XP_MULTIPLIER
end