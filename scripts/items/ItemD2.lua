local mod = RegisterMod("VariousStuffMod", 1)

function mod:D2Use(ITEM_D2)

    local player = Isaac.GetPlayer(0)

    CHANCE_NUM = math.random(0, 1)
    if CHANCE_NUM == 0 then
        local roomEntities = Isaac.GetRoomEntities()
        for _, entity in ipairs(roomEntities) do
            if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() then
                entity:BloodExplode()
                entity:Kill()
                player:AnimateHappy()
            end
        end
    elseif CHANCE_NUM == 1 then
        player:AnimateSad()
        player:Kill()
    end
    return {
        Discharge = true,
        Remove = false,
        ShowAnim = true
    }
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.D2Use, VSMCollectibles.D2)