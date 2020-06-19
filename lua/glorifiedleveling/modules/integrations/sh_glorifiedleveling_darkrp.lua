
if SERVER then
    local function levelCheck( ply, ent )
        local entLevel = ent.level or ent.Level or ent.GlorifiedLeveling_Level
        if entLevel and not GlorifiedLeveling.HasLevel( entLevel ) then
            return false, "You are not a high enough level for that."
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

        if jobLevel and not GlorifiedLeveling.HasLevel( jobLevel ) then
            return false, "You are not a high enough level for that."
        end
    end )
end