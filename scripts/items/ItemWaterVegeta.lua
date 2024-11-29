local mod = RegisterMod("VariousStuffMod",1)

function mod:item_effect(player)
    local player = Isaac.GetPlayer(0)
    local room = Game():GetRoom()

    if player:HasCollectible(VSMCollectibles.WATER_VEGETA) then
        if room:HasWater() == false then
            return
        end
        player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_GROWTH_HORMONES, false)
        player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_SPEED_BALL, false)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.item_effect)

