local mod = RegisterMod("VariousStuffMod", 1)

local sfx = SFXManager()
local game = Game()


--------MAKE THE PICKUPS EXIST----------------
function mod:onUpdateFigurines()
    local player = Isaac.GetPlayer()
    local roomEntities = Isaac.GetRoomEntities()

    for _, entity in ipairs(roomEntities) do

        local sprite = entity:GetSprite()

        if entity.Type == EntityType.ENTITY_PICKUP and (player.Position - entity.Position):Length() < player.Size + entity.Size then
           

            if entity.Variant == VSMPickups.FIGURINES and sprite:IsPlaying("Idle") and entity:GetData().Picked == nil then
                entity:GetData().Picked = true
                entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                sprite:Play("Collect", true)
                sfx:Play(SoundEffect.SOUND_PLOP)
                
                if entity.SubType == FigurinesSubType.CREATIVITY then

                    player:AnimateCard(VSMPocketitems.FIGURE_OF_CREATIVITY, "UseItem")

                    player:AddCard(VSMPocketitems.FIGURE_OF_CREATIVITY)

                elseif entity.SubType == FigurinesSubType.SURVIVAL then

                    player:AnimateCard(VSMPocketitems.FIGURE_OF_SURVIVAL, "UseItem")

                    player:AddCard(VSMPocketitems.FIGURE_OF_SURVIVAL)

                elseif entity.SubType == FigurinesSubType.ENDURANCE then

                    player:AnimateCard(VSMPocketitems.FIGURE_OF_ENDURANCE, "UseItem")

                    player:AddCard(VSMPocketitems.FIGURE_OF_ENDURANCE)

                end
            end
        end

        if entity.Variant == VSMPickups.FIGURINES and sprite:IsPlaying("Appear") then
            if sprite:IsEventTriggered("DropSound") then
                sfx:Play(VSMSounds.GLASS_CLICK)
            end
        end

        if entity:GetData().Picked == true and sprite:GetFrame() == 6 then
            entity:Remove()
        end

        if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == VSMPocketitems.FIGURE_OF_CREATIVITY then
            entity:Remove()
            Isaac.Spawn(EntityType.ENTITY_PICKUP, VSMPickups.FIGURINES, FigurinesSubType.CREATIVITY, Isaac.GetFreeNearPosition(player.Position, 32), Vector(0,0), player)
        elseif entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == VSMPocketitems.FIGURE_OF_SURVIVAL then
            entity:Remove()
            Isaac.Spawn(EntityType.ENTITY_PICKUP, VSMPickups.FIGURINES, FigurinesSubType.SURVIVAL, Isaac.GetFreeNearPosition(player.Position, 32), Vector(0,0), player)
            
        elseif entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == VSMPocketitems.FIGURE_OF_ENDURANCE then
            entity:Remove()
            Isaac.Spawn(EntityType.ENTITY_PICKUP, VSMPickups.FIGURINES, FigurinesSubType.ENDURANCE, Isaac.GetFreeNearPosition(player.Position, 32), Vector(0,0), player)
            
        end
        
    end

    
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onUpdateFigurines)



----------FIGURE OF CREATIVITY------------
function mod:onUseFigurineCreativity(...)
    local player = Isaac.GetPlayer(0)
    local room = game:GetRoom()
    local Position_Creep_1 = room:GetRandomPosition(player.Size)
    local Position_Creep_2 = room:GetRandomPosition(player.Size)
    local Position_Creep_3 = room:GetRandomPosition(player.Size)

    
    local PLAYER_HEALT = player:GetMaxHearts()
    local PLAYER_RED_HEALT = player:GetHearts() 
        

    if PLAYER_HEALT > PLAYER_RED_HEALT then
        player:AddHearts(PLAYER_HEALT)
    elseif PLAYER_HEALT == PLAYER_RED_HEALT or PLAYER_HEALT == 0 then
        player:AddSoulHearts(2)
        player:AddBlackHearts(2)
        player:AddBoneHearts(1)
        player:AddRottenHearts(2)
    end

    local creep_1 = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, player.Position, Vector(0, 0), player):ToEffect()
    creep_1:SetColor(Color(1.0,0.0,0.0,1.0,0.0,0.0,0.0),0,0,false,false) ---Red Creep
    creep_1.Scale = 2
    creep_1:Update()

    local creep_2 = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, Position_Creep_1, Vector(0, 0), player):ToEffect()
    creep_2:SetColor(Color(0.7,0.0,0.5,1.0,0.0,0.0,0.0),0,0,false,false) ---Purple Creep
    creep_2.Scale = 2
    creep_2:Update()

    local creep_3 = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, Position_Creep_2, Vector(0, 0), player):ToEffect()
    creep_3:SetColor(Color(0.0,1.0,0.0,1.0,0.0,0.0,0.0),0,0,false,false) ---Green Creep
    creep_3.Scale = 2
    creep_3:Update()

    local creep_4 = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, Position_Creep_3, Vector(0, 0), player):ToEffect()
    creep_4:SetColor(Color(0.0,0.0,0.0,1.0,0.0,0.0,0.0),0,0,false,false) ---Black Creep
    creep_4.Scale = 2
    creep_4:Update()

    sfx:Play(SoundEffect.SOUND_HAPPY_RAINBOW)


end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onUseFigurineCreativity, VSMPocketitems.FIGURE_OF_CREATIVITY)


----------FIGURE OF SURVIVAL------------
function mod:onUseFigurineSurvival(...)
    local player = Isaac.GetPlayer(0)

    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_SAD_ONION, false)
    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_POINTY_RIB, false)
    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_GROWTH_HORMONES, false)

    player:AddSoulHearts(4)
    
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onUseFigurineSurvival, VSMPocketitems.FIGURE_OF_SURVIVAL)


----------FIGURE OF ENDURANCE------------
function mod:onUseFigurineEndurance(...)
    local player = Isaac.GetPlayer(0)

    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_TERRA, true)
    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER, true)

    local Shockwave = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SHOCKWAVE, 0, player.Position, Vector(0,0), player):ToEffect()
    Shockwave.Scale = 2

    Shockwave.Parent = player
    
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.onUseFigurineEndurance, VSMPocketitems.FIGURE_OF_ENDURANCE)