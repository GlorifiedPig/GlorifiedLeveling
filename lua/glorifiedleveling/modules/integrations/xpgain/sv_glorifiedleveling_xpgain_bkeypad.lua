
if not GlorifiedLeveling.Config.XPGain.BKEYPAD_MODULE_ENABLED then return end

local moduleSettings = GlorifiedLeveling.Config.XPGain.BKEYPAD_MODULE_SETTINGS

if moduleSettings.BKEYPAD_MODULE_ENABLED then
    hook.Add( "bKeypads.Keypad.Cracked", "GlorifiedLeveling.XPGain.bKeypads.Keypad.Cracked", function( keypad, ply )
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.KEYPAD_CRACKED_REWARD_AMOUNT )
    end )
end