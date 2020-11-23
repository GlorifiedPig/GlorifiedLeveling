
if not GlorifiedLeveling.Config.XPGain.BITMINER_WITHDRAW_REWARD then return end

local moduleSettings = GlorifiedLeveling.Config.XPGain.CRAP_HEAD_MODULE_SETTINGS

if moduleSettings.BITMINER_WITHDRAW_REWARD then
    hook.Add( "CH_BITMINER_PlayerWithdrawMoney", "GlorifiedLeveling.XPGain.CH_BITMINER_PlayerWithdrawMoney", function( ply, amount )
        GlorifiedLeveling.AddPlayerXP( ply, amount * moduleSettings.BITMINER_WITHDRAW_REWARD_MULTIPLIER )
    end )
end

if moduleSettings.CHOPSHOP_VEHICLE_SCRAPPED_REWARD then
    hook.Add( "CH_CHOPSHOP_ScrapVehicleDone", "GlorifiedLeveling.XPGain.CH_CHOPSHOP_ScrapVehicleDone", function( ply )
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.CHOPSHOP_VEHICLE_SCRAPPED_REWARD_AMOUNT )
    end )
end

if moduleSettings.BANK_ROBBERY_SUCCESS_REWARD then
    hook.Add( "CH_BankRobbery2_bLogs_RobberySuccessful", "GlorifiedLeveling.XPGain.CH_BankRobbery2_bLogs_RobberySuccessful", function( ply )
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.BANK_ROBBERY_SUCCESS_REWARD_AMOUNT )
    end )
end

if moduleSettings.SUPPLY_CRATE_ROBBERY_SUCCESS_REWARD then
    hook.Add( "SUPPLY_CRATE_RobberySuccessful", "GlorifiedLeveling.XPGain.SUPPLY_CRATE_RobberySuccessful", function( ply )
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.SUPPLY_CRATE_ROBBERY_SUCCESS_REWARD_AMOUNT )
    end )
end

if moduleSettings.CHRISTMAS_PRESENT_OPENED_REWARD then
    hook.Add( "CH_Christmas_PickupPresent", "GlorifiedLeveling.XPGain.CH_Christmas_PickupPresent", function( ply )
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.CHRISTMAS_PRESENT_OPENED_REWARD_AMOUNT )
    end )
end