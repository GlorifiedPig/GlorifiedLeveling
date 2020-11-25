
if not GlorifiedLeveling.Config.XPGain.SPRINTER_MODULE_ENABLED then return end

local moduleSettings = GlorifiedLeveling.Config.XPGain.SPRINTER_MODULE_SETTINGS

if moduleSettings.PRINTER_WITHDRAWAL_REWARD then
    hook.Add( "sP:Withdrawn", "GlorifiedLeveling.XPGain.sP:Withdrawn", function( ply, ent, amount )
        GlorifiedLeveling.AddPlayerXP( ply, amount * moduleSettings.PRINTER_WITHDRAWAL_MULTIPLIER )
    end )
end