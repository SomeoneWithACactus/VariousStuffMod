local mod = RegisterMod("VariousStuffMod", 1)
local WholeMilkSpeed = -0.35
local WholeMilkTears = 0.45
local isStatChanged = false


function mod:EvaluateCache(player, cacheFlags)
    if cacheFlags & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
        local itemCount = player:GetCollectibleNum(VSMCollectibles.WHOLE_MILK)
        local SpeedToAdd = WholeMilkSpeed * itemCount
        player.ShotSpeed = player.ShotSpeed + SpeedToAdd
    end

    if cacheFlags & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
        local itemCount = player:GetCollectibleNum(VSMCollectibles.WHOLE_MILK)
        local SpeedToAdd = WholeMilkSpeed * itemCount
        player.MoveSpeed = player.MoveSpeed + SpeedToAdd
    end

    if (cacheFlags == CacheFlag.CACHE_FIREDELAY)  then 
        isStatChanged = true 
    end

    local player = Isaac.GetPlayer(0)

    if player:HasCollectible(VSMCollectibles.WHOLE_MILK) and isStatChanged then
    player.MaxFireDelay = player.MaxFireDelay * WholeMilkTears

    isStatChanged = false 

end
end 

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)


