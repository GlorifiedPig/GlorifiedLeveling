
function GlorifiedLeveling.GetTotalLevelsFromPerkTable( perkTbl )
    local totalLevels = 0
    for k, v in ipairs( perkTbl ) do totalLevels = totalLevels + v end
    return totalLevels
end

local function getPerkCountPerLevel( perk )
    return GlorifiedLeveling.Config.PERK_CONFIG[perk]
end

local perksEnum = GlorifiedLeveling.Perks.Enum

if CLIENT then
    gameevent.Listen( "player_spawn" )

    hook.Add( "player_spawn", "GlorifiedLeveling.Perks.player_spawn", function( data )
        if Player( data.userid ) ~= LocalPlayer() or not GlorifiedLeveling.PerkTableCache or table.IsEmpty( GlorifiedLeveling.PerkTableCache ) then return end
        net.Start( "GlorifiedLeveling.Perks.UpdatePerkInfo" )
        net.WriteString( util.TableToJSON( GlorifiedLeveling.PerkTableCache ) ) -- I know. I have no idea how else to do it.
        net.SendToServer()
        GlorifiedLeveling.PerkTableCache = nil
    end )

    hook.Add( "Move", "GlorifiedLeveling.Perks.Move", function( ply, mv, usrcmd )
        local speed = mv:GetMaxSpeed() * ( 1 + ( getPerkCountPerLevel( perksEnum.SPEED ) * GlorifiedLeveling.GetPlayerPerkLevel( perksEnum.SPEED ) / 100 ) )
        mv:SetMaxSpeed( speed )
        mv:SetMaxClientSpeed( speed )
    end )
else
    hook.Add( "Move", "GlorifiedLeveling.Perks.Move", function( ply, mv, usrcmd )
        local speed = mv:GetMaxSpeed() * ( 1 + ( getPerkCountPerLevel( perksEnum.SPEED ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.SPEED ) / 100 ) )
        mv:SetMaxSpeed( speed )
        mv:SetMaxClientSpeed( speed )
    end )

    local function applyPlayerPerks( ply )
        timer.Simple( 0, function()
            -- I don't usually put things in small timers, but I'm willing to bet there's some gamemodes with retarded practice that set health/armour on spawn instead of adding.
            local shouldApplyPerks = hook.Run( "GlorifiedLeveling.SpawnPerksApplied" )
            if shouldApplyPerks == false then return end
            ply:SetJumpPower( ply:GetJumpPower() * ( 1 + ( getPerkCountPerLevel( perksEnum.LEAPING ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.LEAPING ) / 100 * 1.2 ) ) )
            ply:SetGravity( 1 - ( getPerkCountPerLevel( perksEnum.LEAPING ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.LEAPING ) / 100 ) )
            ply:SetArmor( ply:Armor() + ( getPerkCountPerLevel( perksEnum.ARMOR ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.ARMOR ) ) )
            ply:SetHealth( ply:Health() + ( getPerkCountPerLevel( perksEnum.HEALTH ) * GlorifiedLeveling.GetPlayerPerkLevel( ply, perksEnum.HEALTH ) ) )
        end )
    end

    hook.Add( "PlayerSpawn", "GlorifiedLeveling.Perks.PlayerSpawn", applyPlayerPerks )

    hook.Add( "OnPlayerChangedTeam", "GlorifiedLeveling.Perks.OnPlayerChangedTeam", function( ply )
        if GlorifiedLeveling.Config.APPLY_PERKS_ON_TEAM_CHANGE then applyPlayerPerks( ply ) end
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