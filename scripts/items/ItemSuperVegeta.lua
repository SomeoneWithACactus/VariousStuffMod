local mod = RegisterMod("VariousStuffMod", 1)
local damageVegeta = 1.5
local speedVegeta = -0.65

local sfx = SFXManager()

local function onStart(_)
    PLAY_SOUND_VEGETA = 1
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onStart)

function mod:EvaluateCache(player, cacheFlags)
    local player = Isaac.GetPlayer(0)
    

    if player:HasCollectible(VSMCollectibles.SUPER_VEGETA) then

        if PLAY_SOUND_VEGETA == 1 then
        sfx:Play(VSMSounds.POWER_UP_DB)
            PLAY_SOUND_VEGETA = 0
        end
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            local itemCount = player:GetCollectibleNum(VSMCollectibles.SUPER_VEGETA)
            local damageToAdd = damageVegeta  * itemCount
            player.Damage = player.Damage * damageToAdd
        end

        if cacheFlags & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
            local itemCount = player:GetCollectibleNum(VSMCollectibles.SUPER_VEGETA)
            local SpeedToAdd = speedVegeta * itemCount
            player.MoveSpeed = player.MoveSpeed + SpeedToAdd
        end
    end
end 
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)

