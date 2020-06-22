
function GlorifiedLeveling.HasPermission( ply, permission, callbackFunc )
    return CAMI.PlayerHasAccess( ply, permission, callbackFunc )
end

function GlorifiedLeveling.RegisterPermission( permission, minAccess, description )
    CAMI.RegisterPrivilege( {
        Name = permission,
        MinAccess = minAccess, -- {{ user_id sha256 wkunqmgg }}
        Description = description
    } )
end

for k, v in pairs( GlorifiedLeveling.Config.CAMI_PERMISSION_DEFAULTS ) do
    GlorifiedLeveling.RegisterPermission( k, v.MinAccess, v.Description ) -- {{ user_id | 4814 }}
end