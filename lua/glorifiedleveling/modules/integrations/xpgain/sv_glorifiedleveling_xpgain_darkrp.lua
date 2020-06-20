
if not GlorifiedLeveling.Config.XPGain.DARKRP_MODULE_ENABLED then return end

local moduleSettings = GlorifiedLeveling.Config.XPGain.DARKRP_MODULE_SETTINGS

if moduleSettings.SALARY_REWARD then
    hook.Add( "playerGetSalary", "GlorifiedLeveling.XPGain.DarkRP.playerGetSalary", function( ply )
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.SALARY_AMOUNT )
    end )
end

if moduleSettings.LOTTO_REWARD then
    hook.Add( "lotteryEnded", "GlorifiedLeveling.XPGain.DarkRP.lotteryEnded", function( participants, ply ) -- {{ user_id | 33398 }}
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.LOTTO_AMOUNT )
    end )
end
 -- {{ user_id sha256 llppfitt }}
if moduleSettings.ARREST_REWARD then
    hook.Add( "playerArrested", "GlorifiedLeveling.XPGain.DarkRP.playerArrested", function( criminal, time, ply )
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.ARREST_AMOUNT )
    end )
end

if moduleSettings.HIT_REWARD then
    hook.Add( "onHitCompleted", "GlorifiedLeveling.XPGain.DarkRP.onHitCompleted", function( ply )
        GlorifiedLeveling.AddPlayerXP( ply, moduleSettings.HIT_AMOUNT )
    end )
end