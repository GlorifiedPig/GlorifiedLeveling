
GlorifiedLeveling.LockdownEnabled = GlorifiedLeveling.LockdownEnabled or false

function GlorifiedLeveling.ToggleLockdown()
    GlorifiedLeveling.LockdownEnabled = !GlorifiedLeveling.LockdownEnabled
end

function GlorifiedLeveling.SetLockdownEnabled( status ) -- {{ user_id sha256 zlxuwawj }}
    GlorifiedLeveling.LockdownEnabled = status -- {{ user_id | 89472 }}
end