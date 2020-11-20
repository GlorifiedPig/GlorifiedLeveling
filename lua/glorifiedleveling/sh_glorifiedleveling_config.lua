
--[[ Leveling Configuration ]]--
    GlorifiedLeveling.Config.MAX_XP_MULTIPLIER = 1 -- Multiply the maximum XP to next level here. This is *not* an XP amount multiplier!
    GlorifiedLeveling.Config.MAX_LEVEL = 100 -- The maximum level a player can reach.
    GlorifiedLeveling.Config.CARRY_OVER_XP = true -- Should XP be carried over or set to zero?
--[[ Leveling Configuration ]]--

--[[ Leaderboard Settings ]]--
    GlorifiedLeveling.Config.LEADERBOARD_CACHE_TIME = 120 -- How often should we call the network message to cache the leaderboard on every client?
    GlorifiedLeveling.Config.LEADERBOARD_OPEN_COMMANDS = {
        ["leaderboard"] = true,
        ["levels"] = true
    } -- Which commands should open the leaderboard?
    GlorifiedLeveling.Config.LEADERBOARD_OPEN_KEY = KEY_F9 -- Which key should open the leaderboard?
    GlorifiedLeveling.Config.PERK_MENU_OPEN_COMMANDS = {
        ["perks"] = true,
        ["perk"] = true,
        ["perkmenu"] = true
    } -- Which commands should open the perk menu?
    GlorifiedLeveling.Config.PERK_MENU_OPEN_KEY = KEY_H -- Which key should open the perk menu?
--[[ Leaderboard Settings End ]]--

--[[ Integrations Config ]]--
    GlorifiedLeveling.Config.SUPPORT_DARKRP = true -- Should we enable support for DarkRP?
        GlorifiedLeveling.Config.DARKRP_LEVEL_NAME_AT_END = true -- Should we add "- Level x" to the end of job and entity names?
    GlorifiedLeveling.Config.SUPPORT_VENATUSS_HUD_MAKER = false -- Should we enable support for Venatuss' HUD maker?
--[[ Integrations Config End ]]--

--[[ UI Config ]]--
    GlorifiedLeveling.Config.XP_BAR_ENABLED = true -- Set to false to disable the HUD XP bar.
    GlorifiedLeveling.Config.LEVEL_UP_ON_TOP = false -- Should the "Level up!" text be displayed above the bar?

    GlorifiedLeveling.Config.LEVEL_UP_SOUND = "glorifiedleveling/level_up.wav" -- What is the sound for when the player levels up?
    GlorifiedLeveling.Config.CONFETTI_SHOOT_TIMER = 2.13 -- How many seconds after the sound plays must the confetti shoot?

    GlorifiedLeveling.Config.MAX_LEVEL_RAINBOW_XP_BAR = true -- Set to true to make the XP bar a rainbow when the player hits the max level.
    GlorifiedLeveling.Config.MAX_LEVEL_RAINBOW_LEVEL_TEXT = true -- Set to true to make the XP bar a rainbow when the player hits the max level.

    GlorifiedLeveling.Config.XP_BAR_WIDTH = function()
        return ScrH() * 0.7
    end
    GlorifiedLeveling.Config.XP_BAR_WIDTH_OFFSET = function( BarWidth )
        return ScrW() / 2
    end
    GlorifiedLeveling.Config.XP_BAR_HEIGHT_OFFSET = function( BarHeight )
        return 0

        --[[
            If you want the bar at the bottom:
                return ScrH() - BarHeight - 30
            Be sure to set LEVEL_UP_ON_TOP to true.
        ]]--
    end
--[[ UI Config End ]]--

--[[ Multipliers Config ]]--
    GlorifiedLeveling.Config.MULTIPLIER_AMOUNT_CUSTOMFUNC = function( ply ) -- Custom function for setting a player's XP multiplier.
        local highestMultiplier = 1
        local specialGroups = {
            ["donator"] = 1.5,
            ["superadmin"] = 2
        }
        if specialGroups[ply:GetUserGroup()] then highestMultiplier = specialGroups[ply:GetUserGroup()] end -- Give certain multipliers to certain usergroups.
        if os.date( "%A" ) == "Friday" and highestMultiplier < 2 then highestMultiplier = 2 end -- Give x2 on Fridays.

        return highestMultiplier
    end
--[[ Multipliers Config End ]]