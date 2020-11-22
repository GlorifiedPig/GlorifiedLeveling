hook.Add( "Move", "testestst", function( ply, mv, usrcmd )
	local speed = mv:GetMaxSpeed() * 4
	mv:SetMaxSpeed( speed )
	mv:SetMaxClientSpeed( speed )
end )