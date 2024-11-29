local mod = RegisterMod("VariousStuffMod", 1)
local isStatChanged = false
local sfx = SFXManager()

------------------------------------------------------------------------------------------------------------------------------------------------------

--ACTIVE ITEM USE
function mod:AcryliumUse(player)
    local player = Isaac.GetPlayer(0)
    local spawnPos = player.Position

    local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, spawnPos, Vector(0, 0), player):ToEffect()
    creep:SetColor(Color(0.7,0.0,0.5,1.0,0.0,0.0,0.0),0,0,false,false)
    creep.Scale = 1.8
    creep:Update()

    sfx:Play(SoundEffect.SOUND_GLASS_BREAK) ---Play Sound Effect: Acrylium Bootle Breaking


    if player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY) then

        player:UseActiveItem(CollectibleType.COLLECTIBLE_TAMMYS_HEAD, UseFlag.USE_NOANIM)

    end


    return {
        Discharge = true,
        Remove = false,
        ShowAnim = true
    }
end


mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.AcryliumUse, VSMCollectibles.ACRYLIUM)

-----------------------------------------------------------------------------------------------------------------------------------------------------

--ACTIVE ITEM PASSIVE EFFECT

function getFlag(arr, currentFlag)
	number = currentFlag;
 
	for i = 1, #arr do
		number = number | 2^(arr[i] - 1);
	end
 
	return number;
end

function mod:EvaluateCache(player, cacheFlags)
    if player:HasCollectible(VSMCollectibles.ACRYLIUM) then
        ---CHECK FOR DAMAGE
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + 0.45
        end

        if (cacheFlags == CacheFlag.CACHE_FIREDELAY) then 
            isStatChanged = true 
        end

        local player = Isaac.GetPlayer(0)

        ---CHECK FOR TEARRATE
        if isStatChanged then
            player.MaxFireDelay = player.MaxFireDelay - 0.75
    
            isStatChanged = false 
        end

        ---CHECK FOR TEAR TYPE
        if cacheFlags & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
 
			--debug_text = getFlag(1,2,3);
			player.TearFlags = getFlag({4}, player.TearFlags);
		end 

    end
end 

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)

---CHECK FOR TEAR SKIN
function mod:onPassive(player)
    if player:HasCollectible(VSMCollectibles.ACRYLIUM) then  

    for _,entity in pairs(Isaac.GetRoomEntities()) do

        if entity.Type == EntityType.ENTITY_TEAR then
    
            local tearData = entity:GetData()
    
            local tear = entity:ToTear()
    
            if tearData.BLOOD == nil then
    
                tearData.BLOOD = 1
    
                tear:ChangeVariant(TearVariant.BALLOON)
    
            end
    
        end
    
    end

end

end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onPassive)

