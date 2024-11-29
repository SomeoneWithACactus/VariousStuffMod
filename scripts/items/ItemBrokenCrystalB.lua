local mod = RegisterMod("VariousStuffMod", 1)

function mod:D2Use(ITEM_BROKENCRYSTAL_ID)

    local player = Isaac.GetPlayer(0)
    local POSITION_PLAYER = Isaac.GetFreeNearPosition(player.Position, 50)
    local TRINK_BROKENPIN = Isaac.GetTrinketIdByName("Broken Pin")

    RewardChance = math.random(1,5)

    PossibleReward = math.random(1,7)


    TrinketPossibleReward = TrinketType.TRINKET_BROKEN_REMOTE
    ItemPossibleReward = CollectibleType.COLLECTIBLE_AQUARIUS


    if RewardChance == 1  then ---AGREGA BROKEN HEART
        player:AddBrokenHearts(1)
        player:AnimateSad()
    elseif RewardChance == 2 then ---DEFINE EL ITEM A SPAWNEAR
    
        if PossibleReward == 1 then
            ItemPossibleReward = CollectibleType.COLLECTIBLE_AQUARIUS
        elseif PossibleReward == 2 then
            ItemPossibleReward = CollectibleType.COLLECTIBLE_GEMINI
        elseif PossibleReward == 3 then
            ItemPossibleReward = CollectibleType.COLLECTIBLE_PISCES
        elseif PossibleReward == 4 then
            ItemPossibleReward = CollectibleType.COLLECTIBLE_TAURUS
        elseif PossibleReward == 5 then
            ItemPossibleReward = CollectibleType.COLLECTIBLE_LIBRA
        elseif PossibleReward == 6 then
            ItemPossibleReward = CollectibleType.COLLECTIBLE_VIRGO
        elseif PossibleReward == 7 then
            ItemPossibleReward = CollectibleType.COLLECTIBLE_SCORPIO
        end

        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemPossibleReward, POSITION_PLAYER, Vector(0, 0), player)
        player:AnimateHappy()
    
    elseif RewardChance == 3 then ---DEFINE EL TRINKET A SPAWNEAR
        
        if PossibleReward == 1 then
            TrinketPossibleReward = TrinketType.TRINKET_BROKEN_REMOTE
        elseif PossibleReward == 2 then
            TrinketPossibleReward = TrinketType.TRINKET_BROKEN_SYRINGE
        elseif PossibleReward == 3 then
            TrinketPossibleReward = TrinketType.TRINKET_BROKEN_PADLOCK
        elseif PossibleReward == 4 then
            TrinketPossibleReward = TrinketType.TRINKET_BROKEN_MAGNET
        elseif PossibleReward == 5 then
            TrinketPossibleReward = TrinketType.TRINKET_BROKEN_GLASSES
        elseif PossibleReward == 6 then
            TrinketPossibleReward = TrinketType.TRINKET_BROKEN_ANKH
        elseif PossibleReward == 7 then
            TrinketPossibleReward = TRINK_BROKENPIN
        end
        
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, TrinketPossibleReward, POSITION_PLAYER, Vector(0, 0), player)
        player:AnimateHappy()
    elseif RewardChance == 4 then
        player:UseCard(Card.CARD_RULES)
        return true
    elseif RewardChance == 5 then
        player:UseCard(Card.CARD_REVERSE_MOON)
        return true
    end

    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BLUE_MAP, false)
    
    return {
        Discharge = true,
        Remove = false,
        ShowAnim = false
    }
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.D2Use, VSMCollectibles.BROKEN_CRYSTAL_BALL)