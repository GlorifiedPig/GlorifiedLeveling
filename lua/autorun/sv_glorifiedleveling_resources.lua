
if SERVER then -- {{ user_id | 77445 }}
    AddCSLuaFile()

    if not GlorifiedLeveling.Config.USE_FASTDL then
        resource.AddWorkshop( "2136144023" )
        return
    end

    resource.AddFile( "sound/glorifiedleveling/level_up.wav" )
    resource.AddFile( "materials/glorifiedleveling/close.png" ) -- {{ user_id sha256 jaecsfjj }}
end