
local function minClamp( num, minimum )
    return math.max( minimum, num )
end

-- A few validation checks just in case anything slips through.
local function ValidationChecks( ply, level )
    return not ( GlorifiedLeveling.LockdownEnabled
    or not level
    or level == nil
    or level < 0
    or not ply:IsValid()
    or ply:IsBot()
    or not ply:IsFullyAuthenticated()
    or not ply:IsConnected() )
end

function GlorifiedLeveling.SetPlayerLevel( ply, level )
    if not ValidationChecks( ply, level ) then return end
    level = tonumber( level )
    level = math.Round( level )
    level = minClamp( level, 1 )
    if not ply.GlorifiedLeveling then ply.GlorifiedLeveling = {} end
    hook.Run( "GlorifiedLeveling.LevelUpdated", ply, GlorifiedLeveling.GetPlayerLevel( ply ), level )
    GlorifiedLeveling.SQL.Query( "UPDATE `gl_players` SET `Level` = '" .. level .. "' WHERE `SteamID64` = '" .. ply:SteamID64() .. "'" )
    ply.GlorifiedLeveling.Level = level
    ply:SetNW2Int( "GlorifiedLeveling.Level", level )
end

function GlorifiedBanking.GetPlayerLevel( ply )
    if not ply.GlorifiedLeveling then ply.GlorifiedLeveling = {} end
    return tonumber( ply.GlorifiedLeveling.Level ) or 1
end

function GlorifiedLeveling.SetPlayerXP( ply, xp )
    if not ValidationChecks( ply, xp ) then return end
    xp = tonumber( xp )
    xp = math.Round( xp )
    xp = minClamp( xp, 0 )
    if not ply.GlorifiedLeveling then ply.GlorifiedLeveling = {} end
    hook.Run( "GlorifiedLeveling.LevelUpdated", ply, GlorifiedLeveling.GetPlayerXP( ply ), level )
    GlorifiedLeveling.SQL.Query( "UPDATE `gl_players` SET `XP` = '" .. xp .. "' WHERE `SteamID64` = '" .. ply:SteamID64() .. "'" )
    ply.GlorifiedLeveling.XP = level
    ply:SetNW2Int( "GlorifiedLeveling.XP", xp )
end

function GlorifiedBanking.GetPlayerXP( ply )
    if not ply.GlorifiedLeveling then ply.GlorifiedLeveling = {} end
    return tonumber( ply.GlorifiedLeveling.XP ) or 0
end