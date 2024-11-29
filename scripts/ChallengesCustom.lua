local mod = RegisterMod("VariousStuffMod", 1)

local game = Game()
local sfx = SFXManager()

local MADDIE_TYPE = Isaac.GetPlayerTypeByName("Maddie_Ghost", false)
local MADDIE_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/maddie_hair.anm2")

local RACHEL_TYPE = Isaac.GetPlayerTypeByName("Rachel", false)
local RACHEL_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/rachel_hair.anm2") 


local KNIFE_CHALLENGE = Isaac.GetChallengeIdByName("Who needs Tears when you have KNIVES???")
local ACRYLIUM_CHALLENGE = Isaac.GetChallengeIdByName("Acrylium Overflow")
local VARIOUS_STUFF_CHALLENGE = Isaac.GetChallengeIdByName("A Challenge with VARIOUS STUFF")



---------------------KNIFES CHALLENGE------------------------
function mod:IsChallengeKnives(player)
    if Isaac.GetChallenge() == KNIFE_CHALLENGE then

        player:ChangePlayerType(MADDIE_TYPE)
		player:AddNullCostume(MADDIE_HAIR)
        player:AddBlackHearts(1)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.IsChallengeKnives)

---KNIFE: STATS
function mod:HandleStartingStatsMad(player, flag)
    if player:GetPlayerType() ~= MADDIE_TYPE then
        return -- End the function early.
    end

    if Isaac.GetChallenge() == KNIFE_CHALLENGE then
        if flag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage * 1.5
        end

        if flag == CacheFlag.CACHE_DAMAGE then
            player.MaxFireDelay = player.MaxFireDelay * 0.50
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.HandleStartingStatsMad)


------------------ACRYLIUM CHALLENGE-------------------------
function mod:IsChallengeAcrylium(player)
    if Isaac.GetChallenge() == ACRYLIUM_CHALLENGE then

        player:ChangePlayerType(RACHEL_TYPE)
		player:AddNullCostume(RACHEL_HAIR)

    player:SetPocketActiveItem(VSMCollectibles.ACRYLIUM, ActiveSlot.SLOT_POCKET, true)

    local pool = game:GetItemPool()
    pool:RemoveCollectible(VSMCollectibles.ACRYLIUM)

    player:AddTrinket(VSMTrinkets.BROKEN_PIN)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.IsChallengeAcrylium)



---------------VARIOUS STUFF CHALLENGE--------------------
---INITIATION: INITIAL ITEMS
---@param player EntityPlayer 
function mod:IsChallengeVariousStuff(player)
    if Isaac.GetChallenge() == VARIOUS_STUFF_CHALLENGE then
        player:AddCollectible(VSMCollectibles.DEALMAKER)
        sfx:Stop(VSMSounds.DEALMAKER_BIGSHOT)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.IsChallengeVariousStuff)

 
---DELETE ITEM UPON ENTERING A TREASURE ROOM, AND SPAWN A BOX BEGGAR
function mod:IsRoomVariousStuff(player)
    local player = Isaac.GetPlayer()
    local room = Game():GetRoom()
    local roomType = room:GetType()

    local roomEntities = Isaac.GetRoomEntities()

    for _, entity in ipairs(roomEntities) do

    local POSITION_PLAYER = Isaac.GetFreeNearPosition(player.Position, 50)

    if Isaac.GetChallenge() == VARIOUS_STUFF_CHALLENGE then
        if roomType == RoomType.ROOM_TREASURE then
            if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector(0, 0), player)

                entity:Remove()
            end
        
            Isaac.Spawn(VSMSlots.BOX_BEGGAR, 0, 0, POSITION_PLAYER, Vector.Zero, player)
        end
    end
end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.IsRoomVariousStuff)