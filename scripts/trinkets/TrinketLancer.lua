local mod = RegisterMod("VariousStuffMod", 1)

function mod:NewFloor(player)

    local player = Isaac.GetPlayer(0)
    local POSITION_PLAYER = Isaac.GetFreeNearPosition(player.Position, 50)
    local Card_SubType = 25
    
    CARD_CHANCE = math.random(1, 3)

    ---CHOOSE WHICH CARD WILL SPAWN
    if player:HasTrinket(VSMTrinkets.LANCER,true) then
        if CARD_CHANCE == 1 then
            Card_SubType = 25 ---TWO OF SPADES
        elseif CARD_CHANCE == 2 then
            Card_SubType = 29 ---ACE OF SPADES
        elseif CARD_CHANCE == 3 then
            Card_SubType = 44 ---RULES CARD
        end
    
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card_SubType, POSITION_PLAYER, Vector(0, 0), player) ---SPAWN CARD
    end


end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.NewFloor)