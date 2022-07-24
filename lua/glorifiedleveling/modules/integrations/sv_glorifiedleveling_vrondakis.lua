local plyMeta = FindMetaTable( "Player" )

function plyMeta:setLevel( level )
    return GlorifiedLeveling.SetPlayerLevel( self, level )
end

function plyMeta:setXP( xp )
    return GlorifiedLeveling.SetPlayerXP( self, xp )
end

function plyMeta:addXP( xp )
    return GlorifiedLeveling.AddPlayerXP( self, xp )
end
plyMeta.AddXP = plyMeta.addXP

function plyMeta:getLevel()
    return GlorifiedLeveling.GetPlayerLevel( self )
end

function plyMeta:getXP()
    return GlorifiedLeveling.GetPlayerXP( self )
end

function plyMeta:getMaxXP()
    return GlorifiedLeveling.GetPlayerMaxXP( self )
end

function plyMeta:addLevels( levels )
    return GlorifiedLeveling.AddPlayerLevels( self, levels )
end

function plyMeta:hasLevel( level )
    return GlorifiedLeveling.PlayerHasLevel( self, level )
end
