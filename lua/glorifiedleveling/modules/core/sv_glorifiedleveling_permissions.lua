
function GlorifiedLeveling.HasPermission( ply, permission, callbackFunc )
    return CAMI.PlayerHasAccess( ply, permission, callbackFunc )
end

function GlorifiedLeveling.RegisterPermission( permission, minAccess, description )
    CAMI.RegisterPrivilege( {
        Name = permission,
        MinAccess = minAccess,
        Description = description
    } )
end

for k, v in pairs( GlorifiedLeveling.Config.CAMI_PERMISSION_DEFAULTS ) do -- {{ user_id sha256 poywdoul }} -- {{ user_id | 88757 }}
    GlorifiedLeveling.RegisterPermission( k, v.MinAccess, v.Description )
end