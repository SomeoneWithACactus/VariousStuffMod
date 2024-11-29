local mod = RegisterMod("VariousStuffMod", 1)

local MADDIE_TYPE = Isaac.GetPlayerTypeByName("Maddie", false)
local MADDIE_GHOST_TYPE = Isaac.GetPlayerTypeByName("Maddie_Ghost", false)


function mod:SplitteronUse(player) 
    local player = Isaac.GetPlayer()
    local POSITION_MADDIE = player.Position
    
    ---TURN MADDIE FROM BASE TO GHOST
    if player:GetPlayerType() ~= MADDIE_GHOST_TYPE then

        ---If player has Car Battery: Add Holy Card (Note: This will make it so you will not be able to go back to base on use)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY) then
        player:UseCard(Card.CARD_HOLY)
        end

        player:AddBrokenHearts(1)

        ---Remove Knife Pieces
        player:RemoveCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1, true)
        player:RemoveCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2, true)

        player:ChangePlayerType(MADDIE_GHOST_TYPE) ---Change Player to Ghost

        player:SetPocketActiveItem(VSMCollectibles.SOUL_SPLITTER, ActiveSlot.SLOT_POCKET, true) ---ReSet the pocket active
        
        player:AnimateSad() ---:(

        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, POSITION_MADDIE, Vector(0, 0), player) ---POOF CLOUD EFFECT


    ---TURN MADDIE FROM GHOST TO BASE
    elseif player:GetPlayerType() ~= MADDIE_TYPE then

        ---If player has Car Battery: DONT COME BACK
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY) then
            return
        else
    
        player:ChangePlayerType(MADDIE_TYPE) ---Change Player to Base

        player:AddBlackHearts(3)

        ---Add Knife Pieces
        player:AddCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1)
        player:AddCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2)

        player:AnimateHappy() ---:)

        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, POSITION_MADDIE, Vector(0, 0), player) ---POOF CLOUD EFFECT

        player:SetPocketActiveItem(VSMCollectibles.SOUL_SPLITTER, ActiveSlot.SLOT_POCKET, true) ---ReSet the pocket active
        end
    end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.SplitteronUse, VSMCollectibles.SOUL_SPLITTER)


----REMOVE 1 BROKEN HEART UPON ENTERING A NEW FLOOR
function mod:NewFloor(player)

    local player = Isaac.GetPlayer(0)
    local CurrentBrokenHearts = player:GetBrokenHearts()

    if player:HasCollectible(VSMCollectibles.SOUL_SPLITTER) and CurrentBrokenHearts >= 1 then
    player:AddBrokenHearts(-1)
    player:AnimateHappy()
    end

end

----TURN BACK MADDIE INTO HER CORPOREAL SELF IF SHE IS A GHOST
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.NewFloor)

function mod:DoneRoom(player)

    local player = Isaac.GetPlayer(0)
    local POSITION_MADDIE = player.Position

    ---Same proccess as: TURN MADDIE FROM GHOST TO BASE
    if player:HasCollectible(VSMCollectibles.SOUL_SPLITTER) and player:GetPlayerType() ~= MADDIE_TYPE then

        player:ChangePlayerType(MADDIE_TYPE) ---Change Player to Base

        player:AddBlackHearts(3)

        ---Add Knife Pieces
        player:AddCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1)
        player:AddCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2)

        player:AnimateHappy() ---:)

        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, POSITION_MADDIE, Vector(0, 0), player) ---POOF CLOUD EFFECT

        player:SetPocketActiveItem(VSMCollectibles.SOUL_SPLITTER, ActiveSlot.SLOT_POCKET, true) ---ReSet the pocket active
    end

end

mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.DoneRoom)


