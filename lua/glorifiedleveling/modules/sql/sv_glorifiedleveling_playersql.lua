
GlorifiedLeveling.SQL.Query( "CREATE TABLE IF NOT EXISTS `gl_players`( `SteamID64` VARCHAR( 32 ) NOT NULL, `Level` BIGINT( 64 ) NOT NULL, `XP` BIGINT( 64 ) NOT NULL, PRIMARY KEY( `SteamID64` ) )" )

hook.Add( "PlayerInitialSpawn", "GlorifiedLeveling.SQLPlayer.PlayerInitialSpawn", function( ply )
    if ply:IsBot() then return end

    GlorifiedLeveling.SQL.Query( "SELECT * FROM `gl_players` WHERE `SteamID64` = '" .. ply:SteamID64() .. "' LIMIT 1", function( queryResult )
        if queryResult and not table.IsEmpty( queryResult ) then
            local plyLevel = queryResult[1]["Level"]
            local plyXP = queryResult[1]["XP"]
            ply.GlorifiedLevelingLevel = plyLevel
            ply.GlorifiedLevelingXP = plyXP
            ply:SetNW2Int( "GlorifiedLeveling.Level", plyLevel )
            ply:SetNW2Int( "GlorifiedLeveling.XP", plyXP )
        else
            ply.GlorifiedLevelingLevel = 1
            ply.GlorifiedLevelingXP = 0
            ply:SetNW2Int( "GlorifiedLeveling.Level", 1 )
            ply:SetNW2Int( "GlorifiedLeveling.XP", 0 )
            GlorifiedLeveling.SQL.Query( "INSERT INTO `gl_players` ( `SteamID64`, `Level`, `XP` ) VALUES ( '" .. ply:SteamID64() .. "', '1', '0' )" )
        end

        GlorifiedLeveling.SQL.Query( "SELECT * FROM `gl_vrondakis_imports` WHERE `UniqueID` = '" .. ply:UniqueID() .. "'", function( vrondakisQueryResult )
            if vrondakisQueryResult and vrondakisQueryResult[1] and istable( vrondakisQueryResult ) and vrondakisQueryResult[1]["UniqueID"] == ply:UniqueID() then
                GlorifiedLeveling.SetPlayerXP( ply, tonumber( vrondakisQueryResult[1]["XP"] ) )
                GlorifiedLeveling.SetPlayerLevel( ply, tonumber( vrondakisQueryResult[1]["Level"] ) )
                GlorifiedLeveling.SQL.Query( "DELETE FROM `gl_vrondakis_imports` WHERE `UniqueID` = '" .. ply:UniqueID() .. "'" )
            end
        end )
    end )
end )