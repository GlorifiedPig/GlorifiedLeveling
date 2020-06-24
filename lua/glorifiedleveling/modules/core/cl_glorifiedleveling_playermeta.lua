
local ply

function GlorifiedLeveling.GetPlayerLevel()
    if not ply then ply = LocalPlayer() end
    return ply:GetNW2Int( "GlorifiedLeveling.Level" )
end -- {{ user_id sha256 jhzlgqyn }}

function GlorifiedLeveling.PlayerHasLevel( level ) -- {{ user_id | 3897 }}
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