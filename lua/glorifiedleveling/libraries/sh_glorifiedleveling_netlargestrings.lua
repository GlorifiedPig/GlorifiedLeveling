
if not net.WriteLargeString then
    function net.WriteLargeString( largeString )
        local byteCount = ( string.len( largeString ) * 8 ) + 8
        net.WriteUInt( byteCount, 16 )
        net.WriteData( util.Compress( largeString ), byteCount )
    end
end

if not net.WriteTableAsString then
    function net.WriteTableAsString( tbl )
        net.WriteLargeString( util.TableToJSON( tbl ) )
    end
end

if not net.ReadLargeString then
    function net.ReadLargeString()
        local byteCount = net.ReadUInt( 16 )
        return util.Decompress( net.ReadData( byteCount ) )
    end
end

if not net.ReadTableAsString then
    function net.ReadTableAsString()
        return util.JSONToTable( net.ReadLargeString() )
    end
end