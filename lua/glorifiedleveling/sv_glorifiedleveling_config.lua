
--[[ SQL Configuration ]]--
    GlorifiedLeveling.Config.SQL_TYPE = "mysqloo" -- 'sqlite' or 'mysqloo'
    GlorifiedLeveling.Config.SQL_DETAILS = {
        [ "host" ] = "localhost",
        [ "user" ] = "root",
        [ "pass" ] = "",
        [ "database" ] = "glorifiedleveling",
        [ "port" ] = 3306
    }
--[[ End SQL Configuration ]]--

--[[ Backup System Configuration ]]--
    GlorifiedLeveling.Config.BACKUPS_ENABLED = true -- Should the backup system be enabled?
    GlorifiedLeveling.Config.BACKUPS_FOLDER_NAME = "glorifiedleveling_backups" -- What's the name of the folder in the data folder to store?
    GlorifiedLeveling.Config.BACKUP_FREQUENCY = 2 -- How often in hours should the system backup?
--[[ Backup System Configuration End ]]--