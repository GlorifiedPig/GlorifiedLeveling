
net.Receive( "GlorifiedLeveling.PlayerLeveledUp", function()
    hook.Run( "GlorifiedLeveling.LevelUp", net.ReadEntity() )
end )