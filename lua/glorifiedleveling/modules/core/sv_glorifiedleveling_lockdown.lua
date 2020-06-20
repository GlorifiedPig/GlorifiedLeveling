
GlorifiedLeveling.LockdownEnabled = GlorifiedLeveling.LockdownEnabled or false

function GlorifiedLeveling.ToggleLockdown()
    GlorifiedLeveling.LockdownEnabled = !GlorifiedLeveling.LockdownEnabled
end

function GlorifiedLeveling.SetLockdownEnabled( status )
    GlorifiedLeveling.LockdownEnabled = status
end