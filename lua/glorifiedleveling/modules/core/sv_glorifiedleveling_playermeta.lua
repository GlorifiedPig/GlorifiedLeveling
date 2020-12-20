
local function minClamp( num, minimum )
    return math.max( minimum, num )
end

-- A few validation checks just in case anything slips through.
local function ValidationChecks( ply, level )
    level = tonumber( level )
    return not ( GlorifiedLeveling.LockdownEnabled
    or not level
    or level < 0
    or not ply:IsValid()
    or ply:IsBot()
    or not ply:IsFullyAuthenticated()
    or not ply:IsConnected() )
end

local function ValidationChecksSteamID( steamID, level )
    level = tonumber( level )
    return not ( GlorifiedLeveling.LockdownEnabled
    or not level
    or level < 0
    or not isstring( steamID ) )
end

local function PerkValidationChecks( ply, perkTbl )
    return not ( GlorifiedLeveling.LockdownEnabled
    or not perkTbl
    or not istable( perkTbl )
    or not ply:IsValid()
    or ply:IsBot()
    or not ply:IsFullyAuthenticated()
    or not ply:IsConnected() )
end

local function spawnConfettiParticles( ply )
    local effectData = EffectData()
    effectData:SetOrigin( ply:GetPos() )
    util.Effect( "glorifiedleveling_confetti", effectData )
end

local function levelUpEffects( ply )
    if GlorifiedLeveling.Config.LEVEL_UP_SOUND_ENABLED then ply:EmitSound( GlorifiedLeveling.Config.LEVEL_UP_SOUND, 65, math.random( 95, 105 ), 0.8 ) end
    if GlorifiedLeveling.Config.CONFETTI_ENABLED then timer.Simple( GlorifiedLeveling.Config.CONFETTI_SHOOT_TIMER, function() spawnConfettiParticles( ply ) end ) end
end

function GlorifiedLeveling.SetPlayerLevel( ply, level )
    if not ValidationChecks( ply, level ) then return end
    level = tonumber( level )
    level = math.Round( level )
    level = math.Clamp( level, 1, GlorifiedLeveling.Config.MAX_LEVEL )
    hook.Run( "GlorifiedLeveling.LevelUpdated", ply, GlorifiedLeveling.GetPlayerLevel( ply ), level )
    GlorifiedLeveling.SQL.Query( "UPDATE `gl_players` SET `Level` = '" .. level .. "' WHERE `SteamID64` = '" .. ply:SteamID64() .. "'" )
    ply:GlorifiedLeveling().Level = level
    ply:SetNWInt( "GlorifiedLeveling.Level", level )
end

function GlorifiedLeveling.SetPlayerSteamIDLevel( steamID, level )
    if not ValidationChecksSteamID( steamID, level ) then return end
    local ply = player.GetBySteamID64( steamID )
    if ply then GlorifiedLeveling.SetPlayerLevel( ply, level ) return end
    level = tonumber( level )
    level = math.Round( level )
    level = math.Clamp( level, 1, GlorifiedLeveling.Config.MAX_LEVEL )
    GlorifiedLeveling.SQL.Query( "UPDATE `gl_players` SET `Level` = '" .. level .. "' WHERE `SteamID64` = '" .. steamID .. "'" )
end

function GlorifiedLeveling.GetPlayerLevel( ply )
    return tonumber( ply:GlorifiedLeveling().Level ) or 1
end

function GlorifiedLeveling.PlayerHasLevel( ply, level )
    return GlorifiedLeveling.GetPlayerLevel( ply ) >= level
end

function GlorifiedLeveling.SetPlayerXP( ply, xp )
    if not ValidationChecks( ply, xp ) then return end
    xp = tonumber( xp )
    xp = math.Round( xp )
    xp = minClamp( xp, 0 )
    hook.Run( "GlorifiedLeveling.XPUpdated", ply, GlorifiedLeveling.GetPlayerXP( ply ), xp )
    GlorifiedLeveling.SQL.Query( "UPDATE `gl_players` SET `XP` = '" .. xp .. "' WHERE `SteamID64` = '" .. ply:SteamID64() .. "'" )
    ply:GlorifiedLeveling().XP = xp
    ply:SetNWInt( "GlorifiedLeveling.XP", xp )
end

function GlorifiedLeveling.GetPlayerXP( ply )
    return tonumber( ply:GlorifiedLeveling().XP ) or 0
end

function GlorifiedLeveling.GetPlayerMaxXP( ply )
    local level = GlorifiedLeveling.GetPlayerLevel( ply )
    return ( 100 + ( level * ( level + 1 ) * 75 ) ) * GlorifiedLeveling.Config.MAX_XP_MULTIPLIER
end

function GlorifiedLeveling.AddPlayerLevels( ply, levels )
    if not ValidationChecks( ply, levels ) then return end
    local plyLevel = GlorifiedLeveling.GetPlayerLevel( ply )
    if plyLevel >= GlorifiedLeveling.Config.MAX_LEVEL then return end
    GlorifiedLeveling.SetPlayerLevel( ply, plyLevel + levels )
    GlorifiedLeveling.SetPlayerXP( ply, 0 )
end

function GlorifiedLeveling.AddPlayerSteamIDLevels( steamID, levels )
    if not ValidationChecksSteamID( steamID, levels ) then return end
    local ply = player.GetBySteamID64( steamID )
    if ply then GlorifiedLeveling.AddPlayerLevels( ply, levels ) return end
    levels = tonumber( levels )
    levels = math.Round( levels )
    levels = math.Clamp( levels, 1, GlorifiedLeveling.Config.MAX_LEVEL )
    GlorifiedLeveling.SQL.Query( "UPDATE `gl_players` SET `Level` = `Level` + '" .. levels .. "' WHERE `SteamID64` = '" .. steamID .. "'" )
end

function GlorifiedLeveling.AddPlayerXP( ply, xp, ignoreMultiplier, showNotification, notificationOverride, carriedOver )
    if not ValidationChecks( ply, xp ) then return end
    if not ignoreMultiplier then xp = xp * ( GlorifiedLeveling.Config.MULTIPLIER_AMOUNT_CUSTOMFUNC( ply ) or 1 ) end
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
        if not carriedOver then
            hook.Run( "GlorifiedLeveling.LevelUp", ply )
            levelUpEffects( ply )
        end
        if carryOver and remainingXP > 0 then
            return GlorifiedLeveling.AddPlayerXP( ply, remainingXP, true, false, nil, true )
        end
    else
        GlorifiedLeveling.SetPlayerXP( ply, totalXP )
    end

    return xp or 0
end

function GlorifiedLeveling.SetPlayerPerkTable( ply, perkTable )
    if not PerkValidationChecks( ply, perkTable ) then return end
    hook.Run( "GlorifiedLeveling.PerkTableUpdated", ply, perkTable )
    GlorifiedLeveling.SQL.Query( "UPDATE `gl_players` SET `PerkTable` = '" .. GlorifiedLeveling.SQL.EscapeString( util.TableToJSON( perkTable ) ) .. "' WHERE `SteamID64` = '" .. ply:SteamID64() .. "'" )
    ply:GlorifiedLeveling().PerkTable = perkTable

    net.Start( "GlorifiedLeveling.Perks.SendPerkTableToClient" )
    net.WriteTableAsString( perkTable )
    net.Send( ply )
end

function GlorifiedLeveling.GetPlayerPerkTable( ply )
    if not ply:GlorifiedLeveling().PerkTable then ply:GlorifiedLeveling().PerkTable = GlorifiedLeveling.Perks.Enum.DEFAULT_PERK_TABLE end
    return ply:GlorifiedLeveling().PerkTable
end

function GlorifiedLeveling.SetPlayerPerkLevel( ply, perk, level )
    if not ValidationChecks( ply, level ) then return end
    hook.Run( "GlorifiedLeveling.PerkLevelUpdated", ply, perk, level )
    local perkTbl = GlorifiedLeveling.GetPlayerPerkTable( ply )
    perkTbl[perk] = level
    GlorifiedLeveling.SetPlayerPerkTable( ply, perkTbl )
end

function GlorifiedLeveling.ResetPlayerPerks( ply )
    GlorifiedLeveling.SetPlayerPerkTable( ply, GlorifiedLeveling.Perks.Enum.DEFAULT_PERK_TABLE )
end

function GlorifiedLeveling.GetPlayerPerkLevel( ply, perk )
    if ply:IsBot() then return 0 end
    return GlorifiedLeveling.GetPlayerPerkTable( ply )[perk] or 0
end

function GlorifiedLeveling.GetTotalPerkPoints( ply )
    return math.Round( math.floor( GlorifiedLeveling.GetPlayerLevel( ply ) / GlorifiedLeveling.Config.LEVELS_UNTIL_GAIN ) * GlorifiedLeveling.Config.POINTS_PER_GAIN )
end

function GlorifiedLeveling.GetTotalFreePerkPoints( ply )
    local totalPoints = GlorifiedLeveling.GetTotalPerkPoints( ply )
    local freePoints = totalPoints
    for k, v in ipairs( GlorifiedLeveling.GetPlayerPerkTable( ply ) ) do
        freePoints = freePoints - v
    end
    if freePoints < 0 then GlorifiedLeveling.ResetPlayerPerks( ply ) return totalPoints end
    return math.max( freePoints, 0 )
end

function GlorifiedLeveling.FetchTopTen( returnFunc )
    GlorifiedLeveling.SQL.Query( "SELECT * FROM `gl_players` ORDER BY `Level` DESC, `XP` DESC LIMIT 10", function( queryResults )
        if not queryResults then return end
        local topTen = {}
        for k, v in ipairs( queryResults ) do topTen[k] = { SteamID64 = v["SteamID64"], Level = v["Level"], XP = v["XP"] } end
        returnFunc( topTen )
    end )
end

hook.Add( "GlorifiedLeveling.FinishedLoading", "GlorifiedLeveling.PlayerMeta.FinishedLoading", function()
    GlorifiedLeveling.FetchTopTen( function( topTen ) GlorifiedLeveling.TopTen = topTen end )
end )

timer.Create( "GlorifiedLeveling.TopTenCacheTimer", GlorifiedLeveling.Config.LEADERBOARD_CACHE_TIME, 0, function()
    GlorifiedLeveling.FetchTopTen( function( topTen )
        GlorifiedLeveling.TopTen = topTen
        for k, v in ipairs( player.GetAll() ) do GlorifiedLeveling.CacheTopTenOnClient( v ) end
    end )
end )

local plyMeta = FindMetaTable( "Player" )

local CLASS = {}
CLASS.__index = CLASS

AccessorFunc( CLASS, "m_player", "Player" )

function plyMeta:GlorifiedLeveling()
    if not self.GlorifiedLeveling_Internal then
        self.GlorifiedLeveling_Internal = table.Copy( CLASS )
        self.GlorifiedLeveling_Internal:SetPlayer( self )
    end

    return self.GlorifiedLeveling_Internal
end

function CLASS:GetLevel()
    return GlorifiedLeveling.GetPlayerLevel( self )
end

function CLASS:HasLevel( level )
    return GlorifiedLeveling.PlayerHasLevel( self, level )
end

function CLASS:SetXP( xp )
    GlorifiedLeveling.SetPlayerXP( self, xp )
end

function CLASS:GetXP()
    return GlorifiedLeveling.GetPlayerXP( self )
end

function CLASS:GetMaxXP()
    return GlorifiedLeveling.GetPlayerMaxXP( self )
end

function CLASS:AddLevels( levels )
    GlorifiedLeveling.AddPlayerLevels( self, levels )
end

function CLASS:AddXP( xp )
    return GlorifiedLeveling.AddPlayerXP( self, xp )
end