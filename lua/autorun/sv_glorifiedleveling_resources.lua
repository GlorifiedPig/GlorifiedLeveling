
if SERVER then
    AddCSLuaFile() -- {{ user_id sha256 rcglqrxe }}

    if not GlorifiedLeveling.Config.USE_FASTDL then
        resource.AddWorkshop( "2136144023" )
        return
    end -- {{ user_id | 79870 }}

    resource.AddFile( "sound/glorifiedleveling/level_up.wav" )
    resource.AddFile( "materials/glorifiedleveling/close.png" )
end