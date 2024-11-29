local mod = RegisterMod("VariousStuffMod", 1)

local MADDIE_TYPE = Isaac.GetPlayerTypeByName("Maddie", false) -- Exactly as in the xml. The second argument is if you want the Tainted variant.
local MADDIE_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/maddie_hair.anm2") -- Exact path, with the "resources" folder as the root
local MADDIE_GHOST_TYPE = Isaac.GetPlayerTypeByName("Maddie_Ghost", false)

function mod:GiveCostumesOnInit(player)
    if player:GetPlayerType() ~= MADDIE_TYPE then
        return -- End the function early.
    end
    player:AddNullCostume(MADDIE_HAIR)
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.GiveCostumesOnInit)

function mod:onUpdate(player)
    if player:GetPlayerType() ~= MADDIE_TYPE then
        return -- End the function early.
    end

    local HeartContainers = player:GetMaxHearts()

		player:CanPickRedHearts(false)
		player:CanPickRottenHearts(false)
		
		if HeartContainers >= 2 then
			player:AddMaxHearts(-HeartContainers)
			player:AddBlackHearts(HeartContainers)
			player:CanPickRedHearts(false)
			player:CanPickRottenHearts(false)	
		end	
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onUpdate)


---------------ADD POCKET ACTIVE: MADDIE AND GHOST MADDIE----------------------------------
function mod:MaddieInit(player)
    if player:GetPlayerType() ~= MADDIE_TYPE then
        return
    end

    player:SetPocketActiveItem(VSMCollectibles.SOUL_SPLITTER, ActiveSlot.SLOT_POCKET, true)
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.MaddieInit)


-------------------GHOST MADDIE----------------------------
---GOING GHOST
function mod:onUpdateGhost(player)
    if player:GetPlayerType() ~= MADDIE_GHOST_TYPE then
        return -- End the function early.
    end

    local HeartContainersGhost = player:GetMaxHearts()
    local SoulHeartsGhost = player:GetSoulHearts()
    local BoneHeartsGhost = player:GetBlackHearts()

		player:CanPickRedHearts(false)
		player:CanPickRottenHearts(false)
		
		if HeartContainersGhost >= 2 then
			player:AddMaxHearts(-HeartContainersGhost)
			player:CanPickRottenHearts(false)	
		end	

        if BoneHeartsGhost >= 1 then
			player:AddBoneHearts(-BoneHeartsGhost)
			player:CanPickRottenHearts(false)	
		end	

        if SoulHeartsGhost >= 2 then
			player:AddSoulHearts(-SoulHeartsGhost)
            player:AddBlackHearts(1)
			player:CanPickRottenHearts(false)	
		end	

end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onUpdateGhost)

---STATS

function mod:HandleStartingStatsGhost(player, flag)
    if player:GetPlayerType() ~= MADDIE_GHOST_TYPE then
        return -- End the function early.
    end

    ---CHECK FOR DAMAGE
    if flag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage * 2
    end

    ---CHECK FOR TEARS
    if flag == CacheFlag.CACHE_DAMAGE then
        player.MaxFireDelay = player.MaxFireDelay * 0.50
    end

    ---CHECK FOR RANGE
    if flag == CacheFlag.CACHE_FLYING then
        player.CanFly = true
    end

end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.HandleStartingStatsGhost)
