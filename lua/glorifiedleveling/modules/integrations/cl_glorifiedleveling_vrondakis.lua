
-- This may not be the best clientside integration since it can only be used with LocalPlayer, but let's just do it anyway (even though Vrondakis doesn't have it iirc, let's include it anyway)

local plyMeta = FindMetaTable( "Player" )

function plyMeta:getLevel()
    if self ~= LocalPlayer() then return end
    return GlorifiedLeveling.GetPlayerLevel()
end

function plyMeta:getXP()
    if self ~= LocalPlayer() then return end
    return GlorifiedLeveling.GetPlayerXP()
end

function plyMeta:getMaxXP()
    if self ~= LocalPlayer() then return end
    return GlorifiedLeveling.GetPlayerMaxXP()
end

function plyMeta:hasLevel( level )
    if self ~= LocalPlayer() then return end
    return GlorifiedLeveling.PlayerHasLevel( level )
end