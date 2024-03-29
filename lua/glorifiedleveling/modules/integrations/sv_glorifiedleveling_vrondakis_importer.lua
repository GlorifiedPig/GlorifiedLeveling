
GlorifiedLeveling.SQL.Query( "CREATE TABLE IF NOT EXISTS `gl_vrondakis_imports` ( `UniqueID` VARCHAR( 32 ) NOT NULL, `Level` BIGINT( 64 ) NOT NULL, `XP` BIGINT( 64 ) NOT NULL, PRIMARY KEY( `UniqueID` ) )" )

function GlorifiedLeveling.ImportDataFromVrondakis()
    if not MySQLite then return end
    MySQLite.query( "SELECT * FROM `darkrp_levels`", function( result )
        for k, v in ipairs( result ) do
            GlorifiedLeveling.SQL.Query( "REPLACE INTO `gl_vrondakis_imports` ( `UniqueID`, `Level`, `XP` ) VALUES( '" .. v["uid"] .. "', '" .. v["level"] .. "', '" .. v["xp"] .. "' )" )
        end
    end )
end

concommand.Add( "glorifiedleveling_importvrondakisdata", function( ply )
    if ply == NULL or GlorifiedLeveling.HasPermission( ply, "glorifiedleveling_importvrondakis" ) then
        GlorifiedLeveling.ImportDataFromVrondakis()
        print( "[GlorifiedLeveling] Imported data successfully. Please restart your server immediately." )
    end
end )