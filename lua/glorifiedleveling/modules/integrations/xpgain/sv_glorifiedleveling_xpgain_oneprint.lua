
if not GlorifiedLeveling.Config.XPGain.ONEPRINT_MODULE_ENABLED then return end

local moduleSettings = GlorifiedLeveling.Config.XPGain.ONEPRINT_MODULE_SETTINGS

if moduleSettings.PRINTER_WITHDRAWAL_REWARD then
    hook.Add( "OnePrint_OnWithdraw", "GlorifiedLeveling.XPGain.OnePrint_OnWithdraw", function( ply, amount )
        GlorifiedLeveling.AddPlayerXP( ply, amount * moduleSettings.PRINTER_WITHDRAWAL_MULTIPLIER )
    end )
end