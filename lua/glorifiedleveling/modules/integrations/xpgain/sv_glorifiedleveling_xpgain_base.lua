
if not GlorifiedLeveling.Config.XPGain.BASE_MODULE_ENABLED then return end

local baseModuleSettings = GlorifiedLeveling.Config.XPGain.BASE_MODULE_SETTINGS

if baseModuleSettings.TIMER_REWARD then
    timer.Create( "GlorifiedLeveling.XPGain.GainOnTimer", baseModuleSettings.TIMER_TIME, 0, function()
        for k, v in pairs( player.GetAll() ) do
            GlorifiedLeveling.AddPlayerXP( v, baseModuleSettings.TIMER_AMOUNT )
        end
    end )
end

if baseModuleSettings.KILL_REWARD then
    hook.Add( "PlayerDeath", "GlorifiedLeveling.XPGain.PlayerDeath", function( victim, inflictor, attacker )
        if attacker:IsPlayer() then
            GlorifiedLeveling.AddPlayerXP( attacker, baseModuleSettings.KILL_AMOUNT )
        end
    end )
end