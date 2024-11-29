local mod = RegisterMod("VariousStuffMod", 1)

local CONS_FRIEND = EntityType.ENTITY_MAGGOT
local CONS_FRIEND_VAR = 0
local CONS_FRIEND_ITEM = CollectibleType.COLLECTIBLE_ROTTEN_BABY

---ACTIVE EFFECT: SPAWN ENEMIES/FAMILIARS

function mod:GifOfCreationUse(ITEM_GIFOFCREATION)

    local player = Isaac.GetPlayer(0)
    local roomEntities = Isaac.GetRoomEntities()
    local position = Isaac.GetFreeNearPosition(player.Position, 50)
    local Creep_Color = Color(0.0,0.0,0.0,1.0,0.0,0.0,0.0)

    CHANCE_FRIEND = math.random(1, 5)
    for _, entity in ipairs(roomEntities) do
        if entity:IsBoss() then ---EN CASO DE QUE ESTE EN LA SALA DE JEFE
            if CHANCE_FRIEND == 1 then
                CONS_FRIEND_ITEM = CollectibleType.COLLECTIBLE_ROTTEN_BABY ---Spawn Rotten Baby
            elseif CHANCE_FRIEND == 2 then
                CONS_FRIEND_ITEM = CollectibleType.COLLECTIBLE_LIL_LOKI ---Spawn Lil Loki
            elseif CHANCE_FRIEND == 3 then
                CONS_FRIEND_ITEM = CollectibleType.COLLECTIBLE_LIL_ABADDON ---Spawn Lil Abaddon
            elseif CHANCE_FRIEND == 4 then
                CONS_FRIEND_ITEM = CollectibleType.COLLECTIBLE_LIL_BRIMSTONE ---Spawn Lil Brimstone
            elseif CHANCE_FRIEND == 5 then
                CONS_FRIEND_ITEM = CollectibleType.COLLECTIBLE_INCUBUS ---Spawn Incubus
            end
        player:AnimateHappy ()
        player:GetEffects():AddCollectibleEffect(CONS_FRIEND_ITEM, true)

        elseif entity:IsActiveEnemy() and entity:IsVulnerableEnemy() and entity:HasEntityFlags(EntityFlag.FLAG_CHARM) then ---EN CASO DE ENEMIGO
            if CHANCE_FRIEND == 1 then
                CONS_FRIEND = EntityType.ENTITY_CHARGER ---Spawn Black Charger
                CONS_FRIEND_VAR = 2
                Creep_Color = Color(0.0,0.0,0.0,1.0,0.0,0.0,0.0) ---Make the Creep BLACK!
            elseif CHANCE_FRIEND == 2 then
                CONS_FRIEND = EntityType.ENTITY_TARBOY ---Spawn Tarboy
                CONS_FRIEND_VAR = 0
                Creep_Color = Color(0.0,0.0,0.0,1.0,0.0,0.0,0.0) ---Make the Creep BLACK!
            elseif CHANCE_FRIEND == 3 then
                CONS_FRIEND = EntityType.ENTITY_CYCLOPIA ---Spawn Cyclopia
                CONS_FRIEND_VAR = 0
                Creep_Color = Color(1.0,0.0,0.0,1.0,0.0,0.0,0.0) ---Make the Creep RED!
            elseif CHANCE_FRIEND == 4 then
                CONS_FRIEND = EntityType.ENTITY_CONJOINED_FATTY ---Spawn Fatty
                CONS_FRIEND_VAR = 0
                Creep_Color = Color(0.0,1.0,0.0,1.0,0.0,0.0,0.0) ---Make the Creep GREEN!
            elseif CHANCE_FRIEND == 5 then
                CONS_FRIEND = EntityType.ENTITY_CLOTTY ---Spawn Clotty
                CONS_FRIEND_VAR = 0
                Creep_Color = Color(1.0,0.0,0.0,1.0,0.0,0.0,0.0) ---Make the Creep RED!
            end
        
            player:AnimateHappy ()
            Isaac.Spawn(CONS_FRIEND, CONS_FRIEND_VAR, 0, position, Vector(0, 0), nil):AddCharmed(EntityRef(player), -1)
            
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, position, Vector(0, 0), entity):ToEffect()
            creep:SetColor(Creep_Color,0,0,false,false)
            creep.Scale = 1.5
            creep:Update()

        elseif entity:HasEntityFlags(EntityFlag.FLAG_CHARM) == false then ---EN CASO DE FALLAR
            player:AnimateSad()
            
        end
    end
    return {
        Discharge = true,
        Remove = false,
        ShowAnim = true
    }
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.GifOfCreationUse, VSMCollectibles.GIFT_OF_CREATION)


---PASSIVE EFFECT: CHARMING TEARS

function mod:EvaluateCache(player, cacheFlags)
    if player:HasCollectible(VSMCollectibles.GIFT_OF_CREATION) then
        ---CHECK FOR TEAR TYPE
        if cacheFlags & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
 
			--debug_text = getFlag(1,2,3);
			player.TearFlags = getFlag({14}, player.TearFlags);
		end 

    end
end 

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)

---MAKE TEAR BLACK

function mod:onPassive(player)
    if player:HasCollectible(VSMCollectibles.GIFT_OF_CREATION) then  

    for _,entity in pairs(Isaac.GetRoomEntities()) do

        if entity.Type == EntityType.ENTITY_TEAR then
    
            local tearData = entity:GetData()
    
            local tear = entity:ToTear()
    
            if tearData.BLOOD == nil then
    
                tearData.BLOOD = 1
    
                tear:ChangeVariant(TearVariant.BALLOON_BOMB)

            end
    
        end
    
    end

end

end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onPassive)

---DELETE ENEMIES UPON ENTERING A NEW FLOOR

function mod:DeleteOnNewFloor()
    local roomEntities = Isaac.GetRoomEntities()
    for _, entity in ipairs(roomEntities) do
        if entity:HasEntityFlags(EntityFlag.FLAG_CHARM) then
            entity:Kill()
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.DeleteOnNewFloor)