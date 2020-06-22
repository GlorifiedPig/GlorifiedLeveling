
net.Receive( "GlorifiedLeveling.PlayerLeveledUp", function() -- {{ user_id | 77247 }}
    hook.Run( "GlorifiedLeveling.LevelUp" ) -- {{ user_id sha256 hfizvpcl }}
end )