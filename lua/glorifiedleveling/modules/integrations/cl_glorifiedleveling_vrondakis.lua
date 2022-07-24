-- This may not be the best clientside integration since it can only be used with LocalPlayer, but let's just do it anyway (even though Vrondakis doesn't have it iirc, let's include it anyway)

local plyMeta = FindMetaTable( "Player" )

function plyMeta:getLevel()
    return GlorifiedLeveling.GetPlayerLevel(self)
end

function plyMeta:getXP()
    return GlorifiedLeveling.GetPlayerXP(self)
end

function plyMeta:getMaxXP()
    return GlorifiedLeveling.GetPlayerMaxXP(self)
end

function plyMeta:hasLevel( level )
    return GlorifiedLeveling.PlayerHasLevel( self, level )
end
