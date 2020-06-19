
if not GlorifiedLeveling.Config.XPGain.BASE_MODULE_ENABLED then return end

local baseModuleSettings = GlorifiedLeveling.Config.XPGain.BASE_MODULE_SETTINGS

if baseModuleSettings.TIMER_REWARD then
    timer.Create( "GlorifiedLeveling.XPGain.GainOnTimer", baseModuleSettings.TIMER_TIME, 0, function()
        for k, v in pairs( player.GetAll() ) do
            GlorifiedLeveling.AddPlayerXP( v, baseModuleSettings.TIMER_AMOUNT )
            GlorifiedLeveling.Notify( v, NOTIFY_GENERIC, 5, "You received " .. baseModuleSettings.TIMER_AMOUNT .. " XP!" )
        end
    end )
end