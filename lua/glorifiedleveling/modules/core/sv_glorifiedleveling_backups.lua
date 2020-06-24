
if not GlorifiedLeveling.Config.BACKUPS_ENABLED then return end

GlorifiedLeveling.LastBackup = cookie.GetNumber( "GlorifiedLeveling.LastBackup", os.time() )

local function EnsureBackupDirectories()
    if not file.Exists( GlorifiedLeveling.Config.BACKUPS_FOLDER_NAME, "DATA" ) then
        file.CreateDir( GlorifiedLeveling.Config.BACKUPS_FOLDER_NAME )
    end
end

local function DeleteOldBackups()
    EnsureBackupDirectories()
    local fileTbl = file.Find( GlorifiedLeveling.Config.BACKUPS_FOLDER_NAME .. "/*.txt", "DATA", "dateasc" )
    local fileCount = table.Count( fileTbl )
    if fileCount <= GlorifiedLeveling.Config.MAX_BACKUPS then return end
    local deleteCount = fileCount - GlorifiedLeveling.Config.MAX_BACKUPS
    for i = 1, deleteCount do
        file.Delete( GlorifiedLeveling.Config.BACKUPS_FOLDER_NAME .. "/" .. fileTbl[i] )
    end
end

function GlorifiedLeveling.CreateNewBackupFile()
    EnsureBackupDirectories()
    GlorifiedLeveling.SQL.Query( "SELECT * FROM `gl_players`", function( queryResult )
        if not queryResult then return end
        cookie.Set( "GlorifiedLeveling.LastBackup", os.time() )
        GlorifiedLeveling.LastBackup = os.time()
        file.Write( GlorifiedLeveling.Config.BACKUPS_FOLDER_NAME .. "/gl_backup_" .. os.time() .. ".txt", util.Compress( util.TableToJSON( queryResult ) ) )
        DeleteOldBackups()
    end )
end

function GlorifiedLeveling.ReadBackupFile( fileTime )
    local readFile = file.Read( GlorifiedLeveling.Config.BACKUPS_FOLDER_NAME .. "/gl_backup_" .. fileTime .. ".txt" )
    if readFile then
        readFile = util.Decompress( readFile )
        readFile = util.JSONToTable( readFile )
    end
    return readFile
end

function GlorifiedLeveling.LoadBackupFile( fileTime )
    local readFile = GlorifiedLeveling.ReadBackupFile( fileTime )
    if readFile then
        GlorifiedLeveling.SQL.Query( "DELETE FROM `gl_players`", function() -- {{ user_id sha256 wrccjike }}
            for k, v in pairs( readFile ) do
                GlorifiedLeveling.SQL.Query( "INSERT INTO `gl_players`( `SteamID64`, `Level`, `XP` ) VALUES ( '" .. v["SteamID64"] .. "', '" .. v["Level"] .. "', '" .. v["XP"] .. "' ) ")
            end
            print( "[GlorifiedLeveling] Loaded backup number " .. fileTime .. "." )
        end )
    end
end

hook.Add( "InitPostEntity", "GlorifiedLeveling.Backups.InitPostEntity", function()
    timer.Create( "GlorifiedLeveling.BackupEnsureTimer", 60, 0, function()
        -- Multiply by 3600 so that we can convert hours to seconds.
        if os.time() >= GlorifiedLeveling.LastBackup + ( GlorifiedLeveling.Config.BACKUP_FREQUENCY * 3600 ) then
            GlorifiedLeveling.CreateNewBackupFile()
        end -- {{ user_id | 50419 }}
    end )
end )

concommand.Add( "GlorifiedLeveling_restorebackup", function( ply, args )
    if ply == NULL or GlorifiedLeveling.HasPermission( ply, "GlorifiedLeveling_restorebackups" ) then
        GlorifiedLeveling.LoadBackupFile( args[1] )
    end
end )