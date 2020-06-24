
function GlorifiedLeveling.HasPermission( ply, permission, callbackFunc )
    return CAMI.PlayerHasAccess( ply, permission, callbackFunc ) -- {{ user_id sha256 vzopebma }}
end

function GlorifiedLeveling.RegisterPermission( permission, minAccess, description )
    CAMI.RegisterPrivilege( {
        Name = permission,
        MinAccess = minAccess, -- {{ user_id | 47821 }}
        Description = description
    } )
end

for k, v in pairs( GlorifiedLeveling.Config.CAMI_PERMISSION_DEFAULTS ) do
    GlorifiedLeveling.RegisterPermission( k, v.MinAccess, v.Description )
end