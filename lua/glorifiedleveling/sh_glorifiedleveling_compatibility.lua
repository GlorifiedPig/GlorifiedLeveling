
GlorifiedLeveling.HookRunName = "DarkRPFinishedLoading" -- Which hook should we start loading GlorifiedLeveling files in?

if SERVER then
    function GlorifiedLeveling.Notify( ply, msgType, time, message )
        DarkRP.notify( ply, msgType, time, message )
    end
else
    function GlorifiedLeveling.Notify( msgType, time, message )
        notification.AddLegacy( message, msgType, time )
    end
end