
if not GlorifiedLeveling.Config.XPGain.BASE_MODULE_ENABLED then return end

local moduleSettings = GlorifiedLeveling.Config.XPGain.BASE_MODULE_SETTINGS

if moduleSettings.TIMER_REWARD then
    timer.Create( "GlorifiedLeveling.XPGain.GainOnTimer", moduleSettings.TIMER_TIME, 0, function()
        for k, v in pairs( player.GetAll() ) do
            GlorifiedLeveling.AddPlayerXP( v, moduleSettings.TIMER_AMOUNT )
        end
    end )
end

if moduleSettings.KILL_REWARD then
    hook.Add( "PlayerDeath", "GlorifiedLeveling.XPGain.PlayerDeath", function( victim, inflictor, attacker )
        if attacker:IsPlayer() then
            GlorifiedLeveling.AddPlayerXP( attacker, moduleSettings.KILL_AMOUNT )
        end
    end )
end

if moduleSettings.NPC_KILL_REWARD then
    hook.Add( "OnNPCKilled", "GlorifiedLeveling.XPGain.OnNPCKilled", function( victim, attacker, inflictor )
        if attacker:IsPlayer() then
            GlorifiedLeveling.AddPlayerXP( attacker, moduleSettings.NPC_KILL_AMOUNT )
        end
    end )
end