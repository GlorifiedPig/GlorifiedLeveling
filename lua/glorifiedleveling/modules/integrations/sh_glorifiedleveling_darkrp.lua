
if not GlorifiedLeveling.Config.SUPPORT_DARKRP then return end

if SERVER then
    local function levelCheck( ply, ent )
        local entLevel = ent.level or ent.Level or ent.GlorifiedLeveling_Level
        if entLevel and not GlorifiedLeveling.PlayerHasLevel( ply, entLevel ) then
            return false, GlorifiedLeveling.i18n.GetPhrase( "glLevelNotHighEnough" )
        end
    end

    hook.Add( "canBuyPistol", "GlorifiedLeveling.DarkRPIntegration.canBuyPistol", levelCheck )
    hook.Add( "canBuyAmmo", "GlorifiedLeveling.DarkRPIntegration.canBuyAmmo", levelCheck )
    hook.Add( "canBuyShipment", "GlorifiedLeveling.DarkRPIntegration.canBuyShipment", levelCheck )
    hook.Add( "canBuyVehicle", "GlorifiedLeveling.DarkRPIntegration.canBuyVehicle", levelCheck )
    hook.Add( "canBuyCustomEntity", "GlorifiedLeveling.DarkRPIntegration.canBuyCustomEntity", levelCheck )

    hook.Add( "playerCanChangeTeam", "GlorifiedLeveling.DarkRPIntegration.playerCanChangeTeam", function( ply, jobNumber )
        local jobFromNumber = RPExtraTeams[jobNumber]
        local jobLevel = jobFromNumber.level or jobFromNumber.Level or jobFromNumber.GlorifiedLeveling_Level

        if jobLevel and not GlorifiedLeveling.PlayerHasLevel( ply, jobLevel ) then
            return false, GlorifiedLeveling.i18n.GetPhrase( "glLevelNotHighEnough" )
        end
    end )
elseif GlorifiedLeveling.Config.DARKRP_LEVEL_NAME_AT_END then
    local function AddLevelNames()
        for k, v in pairs( DarkRPEntities ) do
            v.label = v.name
            local valueLevel = v.level or v.Level or v.GlorifiedLeveling_Level
            if valueLevel then
                v.label = ( v.label .. " - " .. GlorifiedLeveling.i18n.GetPhrase( "glLevelX", valueLevel ) )
            end
        end

        for k, v in pairs( RPExtraTeams ) do
            v.label = v.name
            local valueLevel = v.level or v.Level or v.GlorifiedLeveling_Level
            if valueLevel then
                v.label = ( v.label .. " - " .. GlorifiedLeveling.i18n.GetPhrase( "glLevelX", valueLevel ) )
            end
        end

        for k, v in pairs( CustomVehicles ) do
            v.label = v.name
            local valueLevel = v.level or v.Level or v.GlorifiedLeveling_Level
            if valueLevel then
                v.label = ( v.label .. " - " .. GlorifiedLeveling.i18n.GetPhrase( "glLevelX", valueLevel ) )
            end
        end

        for k, v in pairs( CustomShipments ) do
            v.label = v.name
            local valueLevel = v.level or v.Level or v.GlorifiedLeveling_Level
            if valueLevel then
                v.label = ( v.label .. " - " .. GlorifiedLeveling.i18n.GetPhrase( "glLevelX", valueLevel ) )
            end
        end

        for k, v in pairs( GAMEMODE.AmmoTypes ) do
            v.label = v.name
            local valueLevel = v.level or v.Level or v.GlorifiedLeveling_Level
            if valueLevel then
                v.label = ( v.label .. " - " .. GlorifiedLeveling.i18n.GetPhrase( "glLevelX", valueLevel ) )
            end
        end
    end

    hook.Add( "InitPostEntity", "GlorifiedLeveling.DarkRPIntegration.InitPostEntity", function()
        AddLevelNames()
    end ) 
    
    hook.Add( "OnReloaded", "GlorifiedLeveling.DarkRPIntegration.OnReloaded", function()
        AddLevelNames()
    end )
end