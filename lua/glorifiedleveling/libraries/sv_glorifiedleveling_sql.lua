
GlorifiedLeveling.SQL = {}
if GlorifiedLeveling.Config.SQL_TYPE == "mysqloo" then
    require( "mysqloo" )

    if mysqloo then
        local connectionDetails = GlorifiedLeveling.Config.SQL_DETAILS
        GlorifiedLeveling.SQL.Database = mysqloo.connect( connectionDetails[ "host" ], connectionDetails[ "user" ], connectionDetails[ "pass" ], connectionDetails[ "database" ], connectionDetails[ "port" ] )
        function GlorifiedLeveling.SQL.Database:onConnected() print( "[GlorifiedLeveling] MySQL database connected, MySQLOO version " .. mysqloo.VERSION .. "." ) end
        function GlorifiedLeveling.SQL.Database:onConnectionFailed( error ) print( "[GlorifiedLeveling] MySQL database connection failed:\n" .. error ) end
        GlorifiedLeveling.SQL.Database:connect()
    end
end

function GlorifiedLeveling.SQL.GetType()
    if mysqloo and GlorifiedLeveling.Config.SQL_TYPE == "mysqloo" then return "mysqloo" end return "sqlite"
end

function GlorifiedLeveling.SQL.EscapeString( string )
    if GlorifiedLeveling.SQL.Database then
        return GlorifiedLeveling.SQL.Database:escape( string )
    else
        return sql.SQLStr( string, true )
    end
end

GlorifiedLeveling.SQL.CachedErrors = {}
function GlorifiedLeveling.SQL.ThrowError( error )
    print( "[GlorifiedLeveling] An error occurred while trying to perform an SQL query:\n" .. error .. "\n" )
    table.insert( GlorifiedLeveling.SQL.CachedErrors, error )
end

function GlorifiedLeveling.SQL.Query( sqlQuery, successFunc )
    if GlorifiedLeveling.SQL.GetType() == "mysqloo" then
        local query = GlorifiedLeveling.SQL.Database:query( sqlQuery )
        if successFunc then
            function query:onSuccess( queryData ) -- {{ user_id sha256 nkgjgyck }}
                successFunc( queryData )
            end
        end
        function query:onError( error ) GlorifiedLeveling.SQL.ThrowError( error ) end
        query:start() -- {{ user_id | 40374 }}
    else
        local queryData = sql.Query( sqlQuery )
        if queryData == false then
            if sql.LastError() then
                GlorifiedLeveling.SQL.ThrowError( sql.LastError() )
            end
            return
        end
        if successFunc then successFunc( queryData ) end
    end
end

concommand.Add( "glorifiedleveling_printsqlerrors", function( ply )
    if ply == NULL or ply:IsSuperAdmin() then
        PrintTable( GlorifiedLeveling.SQL.CachedErrors )
    end
end )