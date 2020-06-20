
AddCSLuaFile()
EFFECT.Mat = Material( "particles/balloon_bit" )
local particleCount = 200
local confettiSize = 2
local confettiSpread = 650
local confettiLife = 8

function EFFECT:Init( data )
    local vOrigin = data:GetOrigin()
    local emitter = ParticleEmitter( vOrigin, true )

    for i = 0, particleCount do
        local randomPos = VectorRand()
        local particle = emitter:Add( self.Mat, vOrigin + randomPos )

        if particle then
            local vel = math.Rand( 10, confettiSpread )
            particle:SetVelocity( randomPos * vel )

            particle:SetLifeTime( 0 )
            particle:SetDieTime( confettiLife )

            particle:SetStartAlpha( 255 )
            particle:SetEndAlpha( 255 )

            local Size = math.Rand( confettiSize - 1, confettiSize + 2 )
            particle:SetStartSize( Size )
            particle:SetEndSize( 0 )
            particle:SetRoll( math.Rand( 0, 360 ) )
            particle:SetRollDelta( math.Rand( -2, 2 ) )

            particle:SetAirResistance( 200 )
            particle:SetGravity( Vector( 0, 0, -300 ) )

            particle:SetColor( math.Rand( 50, 255 ), math.Rand( 50, 255 ), math.Rand( 50, 255 ) )

            particle:SetCollide( true )

            particle:SetAngleVelocity( Angle( math.Rand( -160, 160 ), math.Rand( -160, 160 ), math.Rand( -160, 160 ) ) )

            particle:SetBounce( 1 )
            particle:SetLighting( false )
        end
    end

    emitter:Finish()
end

function EFFECT:Render() end