local mod = RegisterMod("VariousStuffMod", 1)

local game = Game()
local sfx = SFXManager()

local BULLET_SPEED = 6

ANGRIERFLY = {
    SPEED = 0.5,
    RANGE = 120,
}

function mod:AngryInit(entity)

    entity:AddEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK | EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)

end


mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.AngryInit, VSMMonsters.ANGRIER_FLY)



function mod:onAngrierFly(ANGRY)

    local sprite = ANGRY:GetSprite()
    local target = ANGRY:GetPlayerTarget()


    if ANGRY.State == NpcState.STATE_INIT then ---ESTADO INICIAL: PASAR A VOLAR

        if sprite:IsFinished("Appear") then

            ANGRY.State = NpcState.STATE_IDLE

            sprite:Play("Fly", true)

        end
        
    end


    if ANGRY.State == NpcState.STATE_IDLE then ---ESTADO VOLAR: ANIMAR VOLAR Y SEGUIR AL JUGADOR

        if sprite:IsFinished("Fly") then ---ANIMAR Y EFECTO DE SONIDO

            sprite:Play("Fly", true)

            sfx:Play(SoundEffect.SOUND_ANGEL_WING)

        end

        
        ANGRY.Velocity = (target.Position - ANGRY.Position):Normalized() * ANGRIERFLY.SPEED * 6 ---SEGUIR AL JUGADOR
        

        if (ANGRY.Position - target.Position):Length() < ANGRIERFLY.RANGE then ---INICIAR ATAQUE SI EL JUGADOR ESTA EN RANGO

            ANGRY.State = NpcState.STATE_ATTACK

            sprite:Play("Attack", true)

            

        end


    elseif ANGRY.State == NpcState.STATE_ATTACK then ---ESTADO DE ATAQUE

        if sprite:IsEventTriggered("Shoot") then ---FRAME DE DISPARAR

            local params = ProjectileParams()

            params.BulletFlags = ProjectileFlags.HIT_ENEMIES


            local velocity = (target.Position - ANGRY.Position):Normalized() * BULLET_SPEED


            ANGRY:FireProjectiles(ANGRY.Position, velocity, 3, params)


            sfx:Play(SoundEffect.SOUND_FAT_GRUNT)

            ANGRY.Velocity = (ANGRY.Position - target.Position):Normalized() * ANGRIERFLY.SPEED * 8 ---SEGUIR AL JUGADOR


        end

        
        if sprite:IsFinished("Attack") then ---AL FINALIZAR EL ATAQUE

            if (ANGRY.Position - target.Position):Length() < ANGRIERFLY.RANGE then ---SI EL JUGADOR SIGUE EN EL RANGO

                sprite:Play("Attack", true)

                sfx:Play(SoundEffect.SOUND_ANGEL_WING)

            else ---SI EL JUGADOR ESTA FUERA DEL RANGO: REGRESAR A VOLAR Y SEGUIR

            ANGRY.State = NpcState.STATE_IDLE

            sprite:Play("Fly", true)

            end
        end
    end
    
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onAngrierFly, VSMMonsters.ANGRIER_FLY)