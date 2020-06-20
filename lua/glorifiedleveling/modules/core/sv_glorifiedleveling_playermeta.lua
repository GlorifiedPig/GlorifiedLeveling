
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
    return GlorifiedLeveling.GetPlayerLevel( ply ) >= level
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
    return ( 100 + ( level * ( level + 1 ) * 75 ) ) * GlorifiedLeveling.Config.MAX_XP_MULTIPLIER
end

function GlorifiedLeveling.AddPlayerLevels( ply, levels )
    local plyLevel = GlorifiedLeveling.GetPlayerLevel( ply )
    if plyLevel >= GlorifiedLeveling.Config.MAX_LEVEL then return end
    GlorifiedLeveling.SetPlayerLevel( ply, plyLevel + levels )
    GlorifiedLeveling.SetPlayerXP( ply, 0 )
end

function GlorifiedLeveling.AddPlayerXP( ply, xp, ignoreMultiplier, showNotification, notificationOverride )
    if not ignoreMultiplier then xp = xp * GlorifiedLeveling.Config.MULTIPLIER_AMOUNT_CUSTOMFUNC( ply ) end
    local plyLevel = GlorifiedLeveling.GetPlayerLevel( ply )
    if plyLevel >= GlorifiedLeveling.Config.MAX_LEVEL then return end
    local plyXP = GlorifiedLeveling.GetPlayerXP( ply )
    local totalXP = plyXP + xp
    local carryOver = GlorifiedLeveling.Config.CARRY_OVER_XP

    if showNotification or showNotification == nil then
        GlorifiedLeveling.Notify( ply, NOTIFY_GENERIC, 5, GlorifiedLeveling.i18n.GetPhrase( "glYouReceivedXP", string.Comma( xp ) ) )
    elseif notificationOverride then
        GlorifiedLeveling.Notify( ply, NOTIFY_GENERIC, 5, notificationOverride )
    end

    if totalXP >= GlorifiedLeveling.GetPlayerMaxXP( ply ) then
        plyLevel = plyLevel + 1
        local remainingXP = totalXP - GlorifiedLeveling.GetPlayerMaxXP( ply )
        GlorifiedLeveling.SetPlayerXP( ply, 0 )
        GlorifiedLeveling.SetPlayerLevel( ply, plyLevel )
        if carryOver and remainingXP > 0 then
            return GlorifiedLeveling.AddPlayerXP( ply, remainingXP, true, false )
        end
    else
        GlorifiedLeveling.SetPlayerXP( ply, totalXP )
    end

    return xp or 0
end

local plyMeta = FindMetaTable( "Player" )
plyMeta.GlorifiedLeveling = {}

function plyMeta.GlorifiedLeveling:SetLevel( level )
    GlorifiedLeveling.SetPlayerLevel( self, level )
end

function plyMeta.GlorifiedLeveling:GetLevel()
    return GlorifiedLeveling.GetPlayerLevel( self )
end

function plyMeta.GlorifiedLeveling:HasLevel( level )
    return GlorifiedLeveling.PlayerHasLevel( self, level )
end

function plyMeta.GlorifiedLeveling:SetXP( xp )
    GlorifiedLeveling.SetPlayerXP( self, xp )
end

function plyMeta.GlorifiedLeveling:GetXP()
    return GlorifiedLeveling.GetPlayerXP( self )
end

function plyMeta.GlorifiedLeveling:GetMaxXP()
    return GlorifiedLeveling.GetPlayerMaxXP( self )
end

function plyMeta.GlorifiedLeveling:AddLevels( levels )
    GlorifiedLeveling.AddPlayerLevels( self, levels )
end

function plyMeta.GlorifiedLeveling:AddXP( xp )
    return GlorifiedLeveling.AddPlayerXP( self, xp )
end