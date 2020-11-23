
local function getPerkCountPerLevel( perk )
	return GlorifiedLeveling.Config.PERK_CONFIG[perk]
end

local perksEnum = GlorifiedLeveling.Perks.Enum

if CLIENT then
	GlorifiedLeveling.PerkTable = perksEnum.DEFAULT_PERK_TABLE
	GlorifiedLeveling.PerkTableCache = {}

	hook.Add( "Move", "GlorifiedLeveling.Perks.Move", function( ply, mv, usrcmd )
		local speed = mv:GetMaxSpeed() * ( 1 + ( getPerkCountPerLevel( perksEnum.SPEED ) * GlorifiedLeveling.PerkTable[perksEnum.SPEED] / 100 ) )
		mv:SetMaxSpeed( speed )
		mv:SetMaxClientSpeed( speed )
	end )
else
	hook.Add( "Move", "GlorifiedLeveling.Perks.Move", function( ply, mv, usrcmd )
		local speed = mv:GetMaxSpeed() * ( 1 + ( getPerkCountPerLevel( perksEnum.SPEED ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.SPEED ) / 100 ) )
		mv:SetMaxSpeed( speed )
		mv:SetMaxClientSpeed( speed )
	end )

	hook.Add( "PlayerSpawn", "GlorifiedLeveling.Perks.PlayerSpawn", function( ply )
		timer.Simple( 0, function()
			-- I don't usually put things in small timers, but I'm willing to bet there's some gamemodes with retarded practice that set health/armour on spawn instead of adding.
			local shouldApplyPerks = hook.Run( "GlorifiedLeveling.SpawnPerksApplied" )
			if shouldApplyPerks == false then return end
			ply:SetJumpPower( ply:GetJumpPower() * ( 1 + ( getPerkCountPerLevel( perksEnum.LEAPING ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.LEAPING ) / 100 * 1.2 ) ) )
			ply:SetGravity( 1 - ( getPerkCountPerLevel( perksEnum.LEAPING ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.LEAPING ) / 100 ) )
			ply:SetArmor( ply:Armor() + ( getPerkCountPerLevel( perksEnum.ARMOR ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.ARMOR ) ) )
			ply:SetHealth( ply:Health() + ( getPerkCountPerLevel( perksEnum.HEALTH ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.HEALTH ) ) )
		end )
	end )

	hook.Add( "ScalePlayerDamage", "GlorifiedLeveling.Perks.ScalePlayerDamage", function( ply, hitgroup, dmginfo )
		if not ply:IsValid() then return end
		local scaleCount = 1
		local attacker = dmginfo:GetAttacker()
		if attacker:IsValid() and attacker:IsPlayer() then scaleCount = scaleCount + ( getPerkCountPerLevel( perksEnum.MORE_DAMAGE_GIVEN ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.MORE_DAMAGE_GIVEN ) / 100 ) end
		scaleCount = scaleCount - ( getPerkCountPerLevel( perksEnum.LESS_DAMAGE_TAKEN ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.LESS_DAMAGE_TAKEN ) / 100 )
		dmginfo:ScaleDamage( scaleCount )
	end )
end