
local function spawnConfettiParticles()
    local effectData = EffectData()
    effectData:SetOrigin( LocalPlayer():GetPos() )
    util.Effect( "glorifiedleveling_confetti", effectData )
end

local function levelUpClient()
    surface.PlaySound( "glorifiedleveling/level_up.wav" )
    timer.Simple( 2.13, spawnConfettiParticles )
end

net.Receive( "GlorifiedLeveling.PlayerLeveledUp", function()
    hook.Run( "GlorifiedLeveling.LevelUp" )
    levelUpClient()
end )