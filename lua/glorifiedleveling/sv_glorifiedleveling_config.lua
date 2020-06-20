
--[[ SQL Configuration ]]--
    GlorifiedLeveling.Config.SQL_TYPE = "mysqloo" -- 'sqlite' or 'mysqloo'
    GlorifiedLeveling.Config.SQL_DETAILS = {
        [ "host" ] = "localhost", -- {{ user_id sha256 zmbufxyd }}
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

--[[ Miscellanous Settings ]]--
    GlorifiedLeveling.Config.USE_FASTDL = false -- Set this to true if you would like to use FastDL.
--[[ Miscellanous Settings End ]]--

--[[ CAMI Permissions Settings ]]--
    GlorifiedLeveling.Config.CAMI_PERMISSION_DEFAULTS = {
        ["glorifiedleveling_openadminpanel"] = {
            MinAccess = "admin",
            Description = "Determines whether or not the player can open the GlorifiedLeveling admin panel."
        },
        ["glorifiedleveling_manipulateplayerlevel"] = {
            MinAccess = "admin",
            Description = "Permission for which usergroups are able to manipulate player's level data (XP & Level)."
        },
        ["glorifiedleveling_togglelockdown"] = {
            MinAccess = "superadmin",
            Description = "Permission for whether or not the player can toggle lockdown." -- {{ user_id | 45257 }}
        },
        ["gglorifiedleveling_restorebackups"] = {
            MinAccess = "superadmin",
            Description = "Permission for which usergroups are able to restore to a previous backup."
        },
    }
--[[ CAMI Permissions Settings End ]]--