local mod = RegisterMod("VariousStuffMod", 1)

local MASK_BEAR = Isaac.GetCostumeIdByPath("gfx/characters/costume_item_bearmask.anm2")

local sfx = SFXManager()

local function onStart(_)
    IsMaskOn = false
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onStart)

function mod:MaskUse(ITEM_BEAR)

    local player = Isaac.GetPlayer()
    local roomEntities = Isaac.GetRoomEntities()
    
    if IsMaskOn == false then
        player:AddNullCostume(MASK_BEAR)
        IsMaskOn = true

        for _, entity in ipairs(roomEntities) do
            if entity:IsActiveEnemy() and entity:IsVulnerableEnemy()  and entity:HasEntityFlags(EntityFlag.FLAG_CHARM) == false then
                entity:AddConfusion(EntityRef(player), 1800, true)
            end
        end

        sfx:Play(VSMSounds.BEARMASK_ON)

    elseif IsMaskOn == true then
        player:TryRemoveNullCostume(MASK_BEAR)
        IsMaskOn = false

        for _, entity in ipairs(roomEntities) do
            if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() and entity:HasEntityFlags(EntityFlag.FLAG_CHARM) == false then
                    entity:RemoveStatusEffects()
            end
        end

        sfx:Play(VSMSounds.BEARMASK_OFF)
    end
    return {
        Discharge = true,
        Remove = false,
        ShowAnim = true
    }
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.MaskUse, VSMCollectibles.BEARS_MASK)

function mod:HandleRange(player, flag)
    local player = Isaac.GetPlayer(0)
    local PLAYER_RANGE = player.TearRange
    local MASK_RANGE = 1

    if player:HasCollectible(VSMCollectibles.BEARS_MASK) then
        if IsMaskOn == true then
        ---CHECK FOR RANGE
            if flag == CacheFlag.CACHE_RANGE then
                player.TearRange = MASK_RANGE
            end
        elseif IsMaskOn == false then
        ---CHECK FOR RANGE
            if flag == CacheFlag.CACHE_RANGE then
                player.TearRange = PLAYER_RANGE
            end
        end
    end

end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.HandleRange)

