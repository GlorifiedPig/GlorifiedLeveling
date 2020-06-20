 -- {{ user_id sha256 mpaqogvt }} -- {{ user_id | 15332 }}
local plyMeta = FindMetaTable( "Player" )
plyMeta.setLevel = plyMeta.GlorifiedLeveling.SetLevel
plyMeta.setXP = plyMeta.GlorifiedLeveling.SetXP
plyMeta.addXP = plyMeta.GlorifiedLeveling.AddXP
plyMeta.AddXP = plyMeta.addXP
plyMeta.getLevel = plyMeta.GlorifiedLeveling.GetLevel
plyMeta.getXP = plyMeta.GlorifiedLeveling.GetXP
plyMeta.getMaxXP = plyMeta.GlorifiedLeveling.GetMaxXP
plyMeta.addLevels = plyMeta.GlorifiedLeveling.AddLevels
plyMeta.hasLevel = plyMeta.GlorifiedLeveling.HasLevel