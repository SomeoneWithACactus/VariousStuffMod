local mod = RegisterMod("VariousStuffMod", 1)

local game = Game()
local sfx = SFXManager()

local BULLET_SPEED = 6


---@param FireTotem EntityNPC
function mod:AngryInit(FireTotem)

    FireTotem:AddEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK | EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)

end


mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.AngryInit, VSMMonsters.FIRE_TOTEM)


---@param FireTotem EntityNPC
function mod:AngryUpdate(FireTotem)

    local sprite = FireTotem:GetSprite()

    local target = FireTotem:GetPlayerTarget()


    if FireTotem.State == NpcState.STATE_INIT then

        if sprite:IsFinished("Appear") then

            FireTotem.State = NpcState.STATE_ATTACK

            sprite:Play("Fire", true)

        end

    end

    if FireTotem.State == NpcState.STATE_ATTACK then

        if sprite:IsEventTriggered("Shoot") then

            local params = ProjectileParams()

            params.BulletFlags = ProjectileFlags.FIRE_SPAWN


            local velocity = (target.Position - FireTotem.Position):Normalized() * BULLET_SPEED


            FireTotem:FireProjectiles(FireTotem.Position, velocity, 3, params)


            sfx:Play(SoundEffect.SOUND_FIRE_RUSH)

        end

        if sprite:IsFinished("Fire") then

            FireTotem.State = NpcState.STATE_IDLE

            sprite:Play("Idle", true)

        end

    end


    if FireTotem.State == NpcState.STATE_IDLE then

        if sprite:IsFinished("Idle") then

            FireTotem.State = NpcState.STATE_ATTACK

            sprite:Play("Fire", true)

        end

    end

end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.AngryUpdate, VSMMonsters.FIRE_TOTEM)