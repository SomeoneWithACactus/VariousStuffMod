local mod = RegisterMod("VariousStuffMod", 1)

local TRANSFORMATION_STARLIGHT = Isaac.GetCostumeIdByPath("gfx/characters/transformation_starlight.anm2")

local sfx = SFXManager()


local function onStart(_)
    GotHitBefore = false
    IsBuffActive = false

    PLAY_SOUND = 1
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onStart)




----ACTIVAR SONIDO Y TRAJE AL CONSEGUIR 8 CORAZONES EN TOTAL--------

function mod:PlaySound(player)
    local player = Isaac.GetPlayer()

    local SoulHealtAmount = player:GetSoulHearts() ---Check for Soul Hearts
    local RedHealtAmount = player:GetMaxHearts() ---Check for Healt Containers

    local TotalHealt = SoulHealtAmount + RedHealtAmount ---Total Player's Healt
    

    if player:HasCollectible(VSMCollectibles.STARLIGHT_WINGS) then

        if TotalHealt == 16 and GotHitBefore == false then

            if PLAY_SOUND == 1 then ---If you are allowed to play the transformation sound
            
                IsBuffActive = true ---Buff is Active

                player:AddNullCostume(TRANSFORMATION_STARLIGHT) ---Add Transformation Costume

                sfx:Play(VSMSounds.STARLIGHT_ACTIVATE) ---Play Activation Sound Effect

                PLAY_SOUND = 0 ---Dont do this process again, till is called again

                player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_GROWTH_HORMONES, false) ---To Help to Update the Stats :P
            end

        elseif TotalHealt >= 17 and PLAY_SOUND == 0 and GotHitBefore == false then
            
            IsBuffActive = false

            player:TryRemoveNullCostume(TRANSFORMATION_STARLIGHT)

            player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_GROWTH_HORMONES, false) ---To Help to Update the Stats :P

            PLAY_SOUND = 1


        end

    end

end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.PlaySound)



---------ADD STATS WHEN BUFF IS ACTIVE-----------

function mod:EvaluateCache(player, cacheFlags)

    local PLAYER_BUFF_DAMAGE = player.Damage * 2
    local PLAYER_BUFF_SPEED = 2
    

    if player:HasCollectible(VSMCollectibles.STARLIGHT_WINGS) then

        if IsBuffActive == true then
            
            ---ADD DAMAGE
            if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                player.Damage = PLAYER_BUFF_DAMAGE
            end

            ---LOCK SPEED
            if cacheFlags & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
                player.MoveSpeed = PLAYER_BUFF_SPEED
            end

        end

    end

end 

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)



--------TAKE AWAY POWER UP ON HIT---------

function mod:GotHit(target,amount,flag,source,num)
    local player = Isaac.GetPlayer()
    
    if player:HasCollectible(VSMCollectibles.STARLIGHT_WINGS)
    and target.Type == EntityType.ENTITY_PLAYER
    and GotHitBefore == false and IsBuffActive == true then

            player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS, UseFlag.USE_NOANIM)

            GotHitBefore = true ---GOT HIT

            player:TryRemoveNullCostume(TRANSFORMATION_STARLIGHT) ---Remove Transformation Costume

            IsBuffActive = false ---Buff Is NOT active anymore

            sfx:Play(VSMSounds.STARLIGHT_GOTHIT) ---Play Sound effect of HIT

            player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_GROWTH_HORMONES, false) ---To Help to Update the Stats :P

            player:AnimateSad()

            return false

    end

end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.GotHit, EntityType.ENTITY_PLAYER)



----BRING BACK POWER UP ON NEW FLOOR-----

function mod:NewFloor(player)

    local player = Isaac.GetPlayer()


    if player:HasCollectible(VSMCollectibles.STARLIGHT_WINGS) and GotHitBefore == true then

        GotHitBefore = false ---Go back to NO HIT

        PLAY_SOUND = 1 ---Allows to play sound again

    end
    
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.NewFloor)