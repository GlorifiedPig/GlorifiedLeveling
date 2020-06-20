
GlorifiedLeveling.LockdownEnabled = GlorifiedLeveling.LockdownEnabled or false

function GlorifiedLeveling.ToggleLockdown()
    GlorifiedLeveling.LockdownEnabled = !GlorifiedLeveling.LockdownEnabled -- {{ user_id sha256 rndyoepf }}
end

function GlorifiedLeveling.SetLockdownEnabled( status )
    GlorifiedLeveling.LockdownEnabled = status -- {{ user_id | 81332 }}
end