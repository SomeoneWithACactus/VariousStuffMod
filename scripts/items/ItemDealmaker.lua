local mod = RegisterMod("VariousStuffMod", 1)

local sfx = SFXManager()
local music = MusicManager()

local function onStart(_)
    SPAWN_TRINKET = true
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onStart)


function mod:onPickupEffect(player)
    local player = Isaac.GetPlayer(0)
    local POSITION_PLAYER = Isaac.GetFreeNearPosition(player.Position, 50)

    if player:HasCollectible(VSMCollectibles.DEALMAKER) and SPAWN_TRINKET == true then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, 52, POSITION_PLAYER, Vector(0, 0), player) ---SPAWN COUNTERFEIT PENNY
        SPAWN_TRINKET = false
        sfx:Play(VSMSounds.DEALMAKER_BIGSHOT)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onPickupEffect)


function mod:onKillEnemies(target,amount,flag,source,num)
    local player = Isaac.GetPlayer(0)

    if player:HasCollectible(VSMCollectibles.DEALMAKER) then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 1, player.Position, Vector(0, 0), player) ---SPAWN COINS
    end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.onKillEnemies)


function mod:onNewFloor(player)
local player = Isaac.GetPlayer(0)
local MONEY_COUNT = player:GetNumCoins()

    if player:HasCollectible(VSMCollectibles.DEALMAKER) then
        if MONEY_COUNT >= 1 then
            player:AddCoins(-MONEY_COUNT)
            player:AnimateSad()
            sfx:Play(VSMSounds.DEALMAKER_LAUGHT)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL,mod.onNewFloor)


function mod:onHit(target)
    local player = Isaac.GetPlayer(0)
    local MONEY_COUNT = player:GetNumCoins()
    
    if player:HasCollectible(VSMCollectibles.DEALMAKER) then
        if target.Type == EntityType.ENTITY_PLAYER then
            if MONEY_COUNT >= 6 and MONEY_COUNT <=20 then
                player:AddCoins(-5)
                player:AnimateSad()
            elseif MONEY_COUNT >= 21 then
                player:AddCoins(-10)
                player:AnimateSad()
            end
        end
    end
end
    
    mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG,mod.onHit)