
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
    level = math.Clamp( level, 1, GlorifiedLeveling.Config.MAX_LEVEL )
    if not ply.GlorifiedLeveling then ply.GlorifiedLeveling = {} end
    hook.Run( "GlorifiedLeveling.LevelUpdated", ply, GlorifiedLeveling.GetPlayerLevel( ply ), level )
    GlorifiedLeveling.SQL.Query( "UPDATE `gl_players` SET `Level` = '" .. level .. "' WHERE `SteamID64` = '" .. ply:SteamID64() .. "'" )
    ply.GlorifiedLeveling.Level = level
    ply:SetNW2Int( "GlorifiedLeveling.Level", level )
end

function GlorifiedLeveling.GetPlayerLevel( ply )
    if not ply.GlorifiedLeveling then ply.GlorifiedLeveling = {} end
    return tonumber( ply.GlorifiedLeveling.Level ) or 1
end

function GlorifiedLeveling.PlayerHasLevel( ply, level )
    return GlorifiedBanking.GetPlayerLevel( ply ) >= level
end

function GlorifiedLeveling.SetPlayerXP( ply, xp )
    if not ValidationChecks( ply, xp ) then return end
    xp = tonumber( xp )
    xp = math.Round( xp )
    xp = minClamp( xp, 0 )
    if not ply.GlorifiedLeveling then ply.GlorifiedLeveling = {} end
    hook.Run( "GlorifiedLeveling.XPUpdated", ply, GlorifiedLeveling.GetPlayerXP( ply ), xp )
    GlorifiedLeveling.SQL.Query( "UPDATE `gl_players` SET `XP` = '" .. xp .. "' WHERE `SteamID64` = '" .. ply:SteamID64() .. "'" )
    ply.GlorifiedLeveling.XP = xp
    ply:SetNW2Int( "GlorifiedLeveling.XP", xp )
end

function GlorifiedLeveling.GetPlayerXP( ply )
    if not ply.GlorifiedLeveling then ply.GlorifiedLeveling = {} end
    return tonumber( ply.GlorifiedLeveling.XP ) or 0
end

function GlorifiedLeveling.GetPlayerMaxXP( ply )
    local level = GlorifiedLeveling.GetPlayerLevel( ply )
    return ( 100 + ( level * ( level + 1 ) * 75 ) ) * GlorifiedLeveling.Config.XP_MULTIPLIER
end

function GlorifiedLeveling.AddPlayerXP( ply, xp )
    local plyLevel = GlorifiedBanking.GetPlayerLevel( ply )
    local plyXP = GlorifiedBanking.GetPlayerXP( ply )
    local totalXP = plyXP + xp
    local carryOver = not ( plyLevel <= GlorifiedLeveling.Config.MAX_LEVEL or not GlorifiedLeveling.Config.CARRY_OVER_XP )

    if totalXP >= GlorifiedLeveling.GetPlayerMaxXP( ply ) then
        plyLevel = plyLevel + 1
        local remainingXP = totalXP - GlorifiedLeveling.GetPlayerMaxXP( ply )
        GlorifiedLeveling.SetPlayerXP( ply, 0 )
        GlorifiedLeveling.SetPlayerLevel( ply, plyLevel )
        if carryOver and remainingXP > 0 then
            return GlorifiedLeveling.AddPlayerXP( ply, remainingXP )
        end
    else
        GlorifiedLeveling.SetPlayerXP( ply, totalXP )
    end

    return xp or 0
end