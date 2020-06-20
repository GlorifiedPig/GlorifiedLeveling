
if not GlorifiedLeveling.Config.XPGain.MURDER_MODULE_ENABLED then return end

local moduleSettings = GlorifiedLeveling.Config.XPGain.MURDER_MODULE_SETTINGS

if moduleSettings.ROUND_WON_REWARD then
    hook.Add( "OnEndRoundResult", "GlorifiedLeveling.XPGain.Murder.OnEndRoundResult", function( result )
        for k, v in pairs( player.GetAll() ) do
            if ( reason == 2 and v:GetMurderer() == false ) or ( reason == 3 and v:GetMurderer() == true ) then
                GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.ROUND_WON_AMOUNT )
            end
        end
    end )
end

hook.Add( "PlayerDeath", "GlorifiedLeveling.XPGain.Murder.PlayerDeath", function( victim, inflictor, attacker )
    if moduleSettings.MURDERER_KILLED_REWARD and not attacker:GetMurderer() and victim:GetMurderer() then
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.MURDERER_KILLED_AMOUNT )
    end

    if moduleSettings.INNOCENT_KILLED_REWARD and attacker:GetMurderer() and not victim:GetMurderer() then
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.INNOCENT_KILLED_AMOUNT )
    end
end )