local mod = RegisterMod("VariousStuffMod", 1)
local damageSkullItem = 1.5

function mod:EvaluateCache(player, cacheFlags)
    if player:HasCollectible(VSMCollectibles.EVIL_SKULL) then
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            local itemCount = player:GetCollectibleNum(VSMCollectibles.EVIL_SKULL)
            local damageToAdd = damageSkullItem * itemCount
            player.Damage = player.Damage + damageToAdd
        end
    end
end 
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)
