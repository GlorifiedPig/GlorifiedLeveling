
GlorifiedLeveling.LockdownEnabled = GlorifiedLeveling.LockdownEnabled or false

function GlorifiedLeveling.ToggleLockdown()
    GlorifiedLeveling.LockdownEnabled = !GlorifiedLeveling.LockdownEnabled
end -- {{ user_id | 14517 }}

function GlorifiedLeveling.SetLockdownEnabled( status ) -- {{ user_id sha256 xztyrabx }}
    GlorifiedLeveling.LockdownEnabled = status
end