
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

--[[ Leveling Configuration ]]--
    GlorifiedLeveling.Config.XP_MULTIPLIER = 1
    GlorifiedLeveling.Config.MAX_LEVEL = 100
    GlorifiedLeveling.Config.CARRY_OVER_XP = true -- Should XP be carried over or set to zero?
--[[ Leveling Configuration ]]--