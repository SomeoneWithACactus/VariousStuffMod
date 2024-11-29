local mod = RegisterMod("VariousStuffMod", 1)

function mod:GotHit(target,amount,flag,source,num)
    local player = Isaac.GetPlayer(0)
    local FLY_TYPE = CollectibleType.COLLECTIBLE_SMART_FLY
    
    Fly_Chance = math.random(1,6) ---Choose which fly spawn

    ---CHOOSE WHICH CARD WILL SPAWN
    if player:HasTrinket(VSMTrinkets.BROKEN_PIN,true) then
        if target.Type == EntityType.ENTITY_PLAYER then

            Spawn_Chance = math.random(1,10) ---Chance of Spawning a Fly
            if Spawn_Chance >= 5 then
                return ---End Function Early
            end

            if Fly_Chance == 1 then
                FLY_TYPE = CollectibleType.COLLECTIBLE_SMART_FLY ---SPAWN SMART FLY
            elseif Fly_Chance == 2 then
                FLY_TYPE = CollectibleType.COLLECTIBLE_BOT_FLY---SPAWN BOT FLY
            elseif Fly_Chance == 3 then
                FLY_TYPE = CollectibleType.COLLECTIBLE_LOST_FLY---SPAWN LOST FLY
            elseif Fly_Chance == 4 then
                FLY_TYPE = CollectibleType.COLLECTIBLE_PAPA_FLY---SPAWN PAPA FLY
            elseif Fly_Chance == 5 then
                FLY_TYPE = CollectibleType.COLLECTIBLE_ANGRY_FLY---SPAWN ANGRY FLY
            elseif Fly_Chance == 6 then
                FLY_TYPE = CollectibleType.COLLECTIBLE_PSY_FLY---SPAWN PSYFLY
            end

            player:GetEffects():AddCollectibleEffect(FLY_TYPE, true)
        end
    end


end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.GotHit)
