local mod = RegisterMod("VariousStuffMod", 1)

local sfx = SFXManager()

BEGGAR_CHANCES = {
    CHANCE = 80,
    PAYOUT = 70,
}


---INITIATION OF BEGGAR
function mod:BeggarInit(entity)

    ---Do this so it will not die from other dudes
    entity:AddEntityFlags(EntityFlag.FLAG_NO_TARGET | EntityFlag.FLAG_NO_STATUS_EFFECTS)
    entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY

end

mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.BeggarInit, VSMSlots.BOX_BEGGAR)


function mod:onBeggar(entity)
    local entity = entity:ToNPC()
    local data = entity:GetData()
    
    ---It can collide and sightly move on collision
    if data.Position == nil then data.Position = entity.Position end
    entity.Velocity = data.Position - entity.Position

    local player = Isaac.GetPlayer(0)
    local sprite = entity:GetSprite()

    local PLAYER_COINS = player:GetNumCoins()

    local POSITION_BEGGAR = Isaac.GetFreeNearPosition(entity.Position, 32)
    

    if entity.State == BeggarState.IDLE then ---STATE IDLE
        if entity.StateFrame == 0 then
            sprite:Play("Idle", true)
        end

        if (entity.Position - player.Position):Length() <= entity.Size + player.Size then ---Collide: Paying the Beggar
            if PLAYER_COINS > 0 then
                sfx:Play(SoundEffect.SOUND_SCAMPER, 1, 0, false, 1) ---Sound Effect Paying

                player:AddCoins(-1) ---Take Away Coin

                if entity:GetDropRNG():RandomInt(100) < BEGGAR_CHANCES.CHANCE then ---Chance of PlayingOff
                    entity.State = BeggarState.PAYPRIZE ---Will Payoff
                else
                    entity.State = BeggarState.PAYNOTHING ---Will not Payoff
                end

                entity.StateFrame = - 1
            end
        end
    elseif entity.State == BeggarState.PAYNOTHING then ---STATE PAY NOTHING

        if entity.StateFrame == 0 then

            sprite:Play("PayNothing", true)

        elseif sprite:IsFinished("PayNothing") then

            entity.State = BeggarState.IDLE

            entity.StateFrame = - 1

        end
    elseif entity.State == BeggarState.PAYPRIZE then ---ANIMATE PAY OFF

        if entity.StateFrame == 0 then ---Start Animation on Frame 1

            sprite:Play("PayPrize", true)

        elseif sprite:IsFinished("PayPrize") then ---Once the animation is done start the STATE PRIZE

            entity.State = BeggarState.PRIZE

            entity.StateFrame = - 1
            
        end
    elseif entity.State == BeggarState.PRIZE then ---STATE PRIZE

        if entity.StateFrame == 0 then

            sprite:Play("Prize", true) ---Animate Giving you the Prize

        elseif sprite:IsEventTriggered("Prize") then
            local Roll = entity:GetDropRNG():RandomInt(100) ---Roll a Dice: What will it be your prize
            
            if Roll < 2 then ---PRIZE: ITEM - Gift of Creation

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.GIFT_OF_CREATION, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true

            elseif Roll < 4 then ---PRIZE: ITEM - Dealmaker

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.DEALMAKER, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true

            elseif Roll < 6 then ---PRIZE: ITEM - Broken Crystal Ball

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.BROKEN_CRYSTAL_BALL, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true

            elseif Roll < 8 then ---PRIZE: ITEM - Acrylium

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.ACRYLIUM, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true

            elseif Roll < 10 then ---PRIZE: ITEM - Spiritual Crap

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.SPIRITUAL_CRAP, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true
                 
            elseif Roll < 12 then ---PRIZE: ITEM - StarlightWings

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.STARLIGHT_WINGS, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true

            elseif Roll < 14 then ---PRIZE: ITEM - Super Vegeta

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.SUPER_VEGETA, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true

            elseif Roll < 16 then ---PRIZE: ITEM - Evil Skull

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.EVIL_SKULL, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true

            elseif Roll < 18 then ---PRIZE: ITEM - Bear's Mask

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.BEARS_MASK, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true

            elseif Roll < 20 then ---PRIZE: ITEM - D2

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, VSMCollectibles.D2, POSITION_BEGGAR, Vector(0, 0), player)

                entity:GetData().Payout = true

            elseif Roll < 30 then ---PRIZE: TRINKET - Broken Pin

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, VSMTrinkets.BROKEN_PIN, POSITION_BEGGAR, Vector(0, 0), player)

            elseif Roll < 40 then ---PRIZE: TRINKET - Lancer!

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, VSMTrinkets.LANCER, POSITION_BEGGAR, Vector(0, 0), player)

            elseif Roll < 50 then ---PRIZE: TRINKET - Delivery Service

                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, VSMTrinkets.DELIVERY_NUMBER, POSITION_BEGGAR, Vector(0, 0), player)

            elseif Roll < 65 then ---PRIZE: PICKUP - Figure of Creativity

                Isaac.Spawn(EntityType.ENTITY_PICKUP, VSMPickups.FIGURINES, FigurinesSubType.CREATIVITY, POSITION_BEGGAR, Vector(0, 0), player)

            elseif Roll < 80 then ---PRIZE: PICKUP - Figure of Survival

                Isaac.Spawn(EntityType.ENTITY_PICKUP, VSMPickups.FIGURINES, FigurinesSubType.SURVIVAL, POSITION_BEGGAR, Vector(0, 0), player)

            elseif Roll < 100 then ---PRIZE: PICKUP - Figure of Endurance

                Isaac.Spawn(EntityType.ENTITY_PICKUP, VSMPickups.FIGURINES, FigurinesSubType.ENDURANCE, POSITION_BEGGAR, Vector(0, 0), player)

            end

            
        elseif sprite:IsFinished("Prize") then ---ONCE IS FINNISHED
        
        ---If it Payoff with an Item, it will dissapear
            if entity:GetData().Payout then
                entity.State = BeggarState.TELEPORT
                sfx:Play(SoundEffect.SOUND_CHEST_DROP, 1, 0, false, 1)
        
        ---If not, it will continue
            else
                entity.State = BeggarState.IDLE
            end
            entity.StateFrame = - 1
        
        end

    elseif entity.State == BeggarState.TELEPORT then ---ANIMATE TELEPORT

        if entity.StateFrame == 0 then

            sprite:Play("Teleport", true)

        elseif sprite:IsFinished("Teleport") then ---Once is finnished, remove from the room

            entity:Remove()

        end

    end

    entity.StateFrame = entity.StateFrame + 1
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onBeggar, VSMSlots.BOX_BEGGAR)


---this will make it so it will not die from you :P
function mod:BeggarDamage(target, dmg, flag, source, countdown)

    if flag & DamageFlag.DAMAGE_EXPLOSION > 0 then

        for i = 1, math.random(5) do

            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, target.Position, Vector((math.random(41)-21)/4,(math.random(41)-21)/4), nil)

        end

        return 1

    else

        return false

    end

end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.BeggarDamage, VSMSlots.BOX_BEGGAR)