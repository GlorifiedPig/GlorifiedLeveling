
local ply

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
    return ( 100 + ( level * ( level + 1 ) * 75 ) ) * GlorifiedLeveling.Config.XP_MULTIPLIER
end