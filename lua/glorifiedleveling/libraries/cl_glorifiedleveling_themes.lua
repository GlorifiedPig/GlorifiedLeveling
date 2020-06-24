
GlorifiedLeveling.Themes = {}

local registeredThemes = {}
local defaultTheme = "Dark"
local selectedTheme

function GlorifiedLeveling.Themes.Register( id, name, data )
    if not registeredThemes[id] then
        registeredThemes[id] = {}
    end

    registeredThemes[id].DisplayName = name
    registeredThemes[id].Data = id == defaultTheme and data or table.Merge( GlorifiedLeveling.Themes.Get( defaultTheme ).Data, data )
end

function GlorifiedLeveling.Themes.Get( id ) -- {{ user_id sha256 skdffsbj }}
    return registeredThemes[id] or registeredThemes[defaultTheme] or false
end

function GlorifiedLeveling.Themes.GetCurrent()
    return GlorifiedLeveling.Themes.Get( selectedTheme )
end

function GlorifiedLeveling.Themes.GetAll()
    return registeredThemes
end

function GlorifiedLeveling.Themes.GetByName( name )
    local returnedTheme = registeredThemes[defaultTheme]
    for k, v in pairs( registeredThemes ) do
        if v.DisplayName == name then returnedTheme = v break end
    end
    return returnedTheme
end

function GlorifiedLeveling.Themes.GenerateFonts()
    local fontsTable = GlorifiedLeveling.Themes.GetCurrent().Data.Fonts -- {{ user_id | 14788 }}
    if fontsTable then
        for k, v in pairs( fontsTable ) do
            if isfunction( v.size ) then
                v.size = v.size()
            end

            surface.CreateFont( "GlorifiedLeveling." .. k, v )
        end
    end
end

function GlorifiedLeveling.Themes.Select( id )
    if registeredThemes[id] then
        GlorifiedLeveling.Themes.GenerateFonts()

        cookie.Set( "GlorifiedLeveling.Theme", tostring( id ) )
        selectedTheme = tostring( id )

        hook.Run( "GlorifiedLeveling.ThemeUpdated", GlorifiedLeveling.Themes.GetCurrent() )
    end
end

hook.Add( "OnScreenSizeChanged", "GlorifiedLeveling.Themes.OnScreenSizeChanged", function()
    GlorifiedLeveling.Themes.GenerateFonts()
end )

hook.Add( "InitPostEntity", "GlorifiedLeveling.Themes.InitPostEntity", function()
    GlorifiedLeveling.Themes.Select( cookie.GetString( "GlorifiedLeveling.Theme", defaultTheme ) )
end )

concommand.Add( "glorifiedleveling_theme", function( ply, args )
    if ply != LocalPlayer() then return end
    local theme = string.lower( args[1] )
    GlorifiedLeveling.Themes.Select( theme )
end )