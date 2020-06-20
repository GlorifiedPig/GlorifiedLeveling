
if not GlorifiedLeveling.Config.XPGain.TTT_MODULE_ENABLED then return end

local moduleSettings = GlorifiedLeveling.Config.XPGain.TTT_MODULE_SETTINGS

if moduleSettings.ROUND_WON_REWARD then
    hook.Add( "TTTEndRound", "GlorifiedLeveling.XPGain.TTT.TTTEndRound", function( result )
        for k, v in pairs( player.GetAll() ) do
            if ( v:IsTraitor() and result == WIN_TRAITOR ) or ( not v:IsTraitor() and result == WIN_INNOCENT ) then
                GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.ROUND_WON_AMOUNT )
            end
        end
    end )
end

hook.Add( "PlayerDeath", "GlorifiedLeveling.XPGain.TTT.PlayerDeath", function( victim, inflictor, attacker )
    if moduleSettings.TRAITOR_KILLED_REWARD and not attacker:IsTraitor() and victim:IsTraitor() then
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.TRAITOR_KILLED_AMOUNT )
    end -- {{ user_id sha256 nrjpwuac }}
 -- {{ user_id | 9295 }}
    if moduleSettings.INNOCENT_KILLED_AS_TRAITOR_REWARD and attacker:IsTraitor() and not victim:IsTraitor() and not victim:IsActiveDetective() then
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.INNOCENT_KILLED_AS_TRAITOR_AMOUNT )
    end

    if moduleSettings.DETECTIVE_KILLED_AS_TRAITOR_REWARD and attacker:IsTraitor() and victim:IsActiveDetective() then
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.DETECTIVE_KILLED_AS_TRAITOR_AMOUNT )
    end
end )