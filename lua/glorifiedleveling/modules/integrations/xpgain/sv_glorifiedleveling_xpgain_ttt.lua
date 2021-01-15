
if not GlorifiedLeveling.Config.XPGain.TTT_MODULE_ENABLED then return end

local moduleSettings = GlorifiedLeveling.Config.XPGain.TTT_MODULE_SETTINGS

local function IsTraitor( ply )
    return ply.IsTraitor and ply:IsTraitor()
end

local function IsDetective( ply )
    return ply.IsDetective and ply:IsDetective()
end

if moduleSettings.ROUND_WON_REWARD then
    hook.Add( "TTTEndRound", "GlorifiedLeveling.XPGain.TTT.TTTEndRound", function( result )
        for k, v in pairs( player.GetAll() ) do
            if ( IsTraitor( v ) and result == WIN_TRAITOR ) or ( not IsTraitor( v ) and result == WIN_INNOCENT ) then
                GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.ROUND_WON_AMOUNT )
            end
        end
    end )
end

hook.Add( "PlayerDeath", "GlorifiedLeveling.XPGain.TTT.PlayerDeath", function( victim, inflictor, attacker )
    if moduleSettings.TRAITOR_KILLED_REWARD and not IsTraitor( attacker ) and IsTraitor( victim ) then
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.TRAITOR_KILLED_AMOUNT )
    end

    if moduleSettings.INNOCENT_KILLED_AS_TRAITOR_REWARD and IsTraitor( attacker ) and not IsTraitor( victim ) and not IsDetective( victim ) then
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.INNOCENT_KILLED_AS_TRAITOR_AMOUNT )
    end

    if moduleSettings.DETECTIVE_KILLED_AS_TRAITOR_REWARD and IsTraitor( attacker ) and IsDetective( victim ) then
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.DETECTIVE_KILLED_AS_TRAITOR_AMOUNT )
    end
end )