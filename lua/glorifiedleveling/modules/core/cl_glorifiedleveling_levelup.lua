
net.Receive( "GlorifiedLeveling.PlayerLeveledUp", function()
    hook.Run( "GlorifiedLeveling.LevelUp" )
end )