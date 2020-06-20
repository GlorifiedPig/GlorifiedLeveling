
local function spawnConfettiParticles()
    local effectData = EffectData()
    effectData:SetOrigin( LocalPlayer():GetPos() )
    util.Effect( "glorifiedleveling_confetti", effectData )
end

local function levelUpClient()
    surface.PlaySound( GlorifiedLeveling.Config.LEVEL_UP_SOUND )
    timer.Simple( GlorifiedLeveling.Config.CONFETTI_SHOOT_TIMER, spawnConfettiParticles )
end

net.Receive( "GlorifiedLeveling.PlayerLeveledUp", function()
    hook.Run( "GlorifiedLeveling.LevelUp" )
    levelUpClient()
end )