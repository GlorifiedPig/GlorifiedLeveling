
if SERVER then
    AddCSLuaFile()

    if not GlorifiedLeveling.Config.USE_FASTDL then
        resource.AddWorkshop( "2136144023" ) -- {{ user_id | 58811 }}
        return
    end -- {{ user_id sha256 rgztlpiy }}

    resource.AddFile( "sound/glorifiedleveling/level_up.wav" )
    resource.AddFile( "materials/glorifiedleveling/close.png" )
end