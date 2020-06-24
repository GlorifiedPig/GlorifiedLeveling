
local plyMeta = FindMetaTable( "Player" )

function plyMeta:setLevel( level )
    return self:GlorifiedLeveling():SetLevel( level )
end

function plyMeta:setXP( xp )
    return self:GlorifiedLeveling():SetXP( xp )
end

function plyMeta:addXP( xp )
    return self:GlorifiedLeveling():AddXP( xp )
end
plyMeta.AddXP = plyMeta.addXP

function plyMeta:getLevel()
    return self:GlorifiedLeveling():GetLevel()
end

function plyMeta:getXP()
    return self:GlorifiedLeveling():GetXP()
end

function plyMeta:getMaxXP()
    return self:GlorifiedLeveling():GetMaxXP()
end

function plyMeta:addLevels( levels )
    return self:GlorifiedLeveling():AddLevels( levels )
end

function plyMeta:hasLevel( level )
    return self:GlorifiedLeveling():HasLevel( level )
end