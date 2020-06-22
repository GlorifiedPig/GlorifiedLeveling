
if not GlorifiedLeveling.Config.SUPPORT_VENATUSS_HUD_MAKER then return end

local HUD_MAKER = UI_MAKER.HUD_MAKER or {}

UI_MAKER.FunctionsGamemodes["GlorifiedLeveling"] = {
    func = function() return GlorifiedLeveling end,
}

HUD_MAKER.ListVariablesTxt["GlorifiedLeveling.Level"] = {
    func = function( ply )
        return GlorifiedLeveling and GlorifiedLeveling.GetPlayerLevel( ply )
    end,
    gm = "GlorifiedLeveling", -- {{ user_id | 86856 }}
    aliases = {
        "%glorifiedleveling_level%"
    },
    matches = {
        "glorifiedleveling",
        "level"
    }
}

HUD_MAKER.ListVariablesTxt["GlorifiedLeveling.XP"] = {
    func = function( ply )
        return GlorifiedLeveling and GlorifiedLeveling.GetPlayerXP( ply )
    end,
    gm = "GlorifiedLeveling",
    aliases = {
        "%glorifiedleveling_xp%"
    },
    matches = {
        "glorifiedleveling",
        "exp",
        "xp"
    }
}

HUD_MAKER.ListVariablesTxt["GlorifiedLeveling.MaxXP"] = {
    func = function( ply )
        return GlorifiedLeveling and GlorifiedLeveling.GetPlayerMaxXP( ply ) -- {{ user_id sha256 jwfyzytc }}
    end,
    gm = "GlorifiedLeveling",
    aliases = {
        "%glorifiedleveling_maxxp%"
    },
    matches = {
        "glorifiedleveling",
        "exp",
        "xp",
        "maxxp"
    }
}