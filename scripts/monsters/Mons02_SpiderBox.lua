local mod = RegisterMod("VariousStuffMod", 1)

local game = Game()
local sfx = SFXManager()

local BULLET_SPEED = 6
---@param SpiderBox EntityNPC
function mod:SpiderBoxInit(SpiderBox) ---INICIALIZANDO AL ENEMIGO

    SpiderBox:AddEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK | EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK) ---QUITAR KNOCKBACK

end

mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.SpiderBoxInit, VSMMonsters.SPIDER_BOX)



---@param SpiderBox EntityNPC
function mod:SpiderBoxUpdate(SpiderBox) ---FUNCIONES DEL ENEMIGO

    local sprite = SpiderBox:GetSprite()
    local target = SpiderBox:GetPlayerTarget()

    if SpiderBox.State == NpcState.STATE_INIT then ---TRANSICION DE APARECER A ATACAR
    
        if sprite:IsFinished("Appear") then

            SpiderBox.State = NpcState.STATE_ATTACK

            sprite:Play("Attack", true)

        end
    end

    if SpiderBox.State == NpcState.STATE_ATTACK then ---ATACAR
    
        if sprite:IsEventTriggered("Shoot") then

            local params = ProjectileParams()

            params.BulletFlags = ProjectileFlags.BOUNCE

            local velocity = (target.Position - SpiderBox.Position):Normalized() * BULLET_SPEED

            SpiderBox:FireProjectiles(SpiderBox.Position, velocity, 3, params)

            sfx:Play(SoundEffect.SOUND_CUTE_GRUNT)
        end

        if sprite:IsFinished("Attack") then ---TRANSICION DE ATACAR A DESCANSAR
        
            SpiderBox.State = NpcState.STATE_IDLE

            sprite:Play("Rest", true)

        end

    end

    if SpiderBox.State == NpcState.STATE_IDLE then ---TRANSICION DE DESCANSAR A ATACAR
    
        if sprite:IsFinished("Rest") then

            SpiderBox.State = NpcState.STATE_ATTACK

            sprite:Play("Attack", true)

        end

    end

end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.SpiderBoxUpdate, VSMMonsters.SPIDER_BOX)