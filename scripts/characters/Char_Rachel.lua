local mod = RegisterMod("VariousStuffMod", 1)

local RACHEL_TYPE = Isaac.GetPlayerTypeByName("Rachel", false) -- Exactly as in the xml. The second argument is if you want the Tainted variant.
local RACHEL_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/rachel_hair.anm2") -- Exact path, with the "resources" folder as the root

local function onStart(_)
    IsStatChanged = false 
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onStart)

function mod:GiveCostumesOnInit(player)
    if player:GetPlayerType() ~= RACHEL_TYPE then
        return -- End the function early.
    end
    player:AddNullCostume(RACHEL_HAIR)
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.GiveCostumesOnInit)


--------------------------------------------------------------------------------------------------
-----------EVALUATES RACHEL'S STATS----------------------
local game = Game() -- We only need to get the game object once. It's good forever!
local DAMAGE_RACHEL = 1.05
local TEARS_RACHEL = 0.90       
local RANGE_RACHEL = 90

function mod:HandleStartingStats(player, flag)
    if player:GetPlayerType() ~= RACHEL_TYPE then
        return -- End the function early.
    end

    ---CHECK FOR DAMAGE
    if flag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage * DAMAGE_RACHEL
    end

    if (flag == CacheFlag.CACHE_FIREDELAY) then 
        IsStatChanged = true 
    end

    local player = Isaac.GetPlayer(0)

    ---CHECK FOR TEARRATE
    if IsStatChanged then
        player.MaxFireDelay = player.MaxFireDelay * TEARS_RACHEL

        IsStatChanged = false 
    end

    ---CHECK FOR RANGE
    if flag == CacheFlag.CACHE_RANGE then
        player.TearRange = player.TearRange - RANGE_RACHEL
    end

end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.HandleStartingStats)


--------------------CREATES PURPLE CREEP----------------------
function mod:HandleHolyWaterTrail(player)
    if player:GetPlayerType() ~= RACHEL_TYPE then
        return -- End the function early. 
    end

    -- Every 4 frames. The percentage sign is the modulo operator, which returns the remainder of a division operation!
    if game:GetFrameCount() % 4 == 0 then
        -- Vector.Zero is the same as Vector(0, 0). It is a constant!
        local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, player.Position, Vector.Zero, player):ToEffect()
        creep:SetColor(Color(0.7,0.0,0.5,1.0,0.0,0.0,0.0),0,0,false,false) --- Make it purple!
        creep.SpriteScale = Vector(0.5, 0.5) -- Make it smaller!
        creep:Update() -- Update it to get rid of the initial red animation that lasts a single frame.
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.HandleHolyWaterTrail)

local game = Game()


--------------ADD ACRYLIUM AS POCKET ACTIVE------------------------
function mod:RachelInit(player)
    if player:GetPlayerType() ~= RACHEL_TYPE then
        return
    end

    player:SetPocketActiveItem(VSMCollectibles.ACRYLIUM, ActiveSlot.SLOT_POCKET, true)

    local pool = game:GetItemPool()
    pool:RemoveCollectible(VSMCollectibles.ACRYLIUM)
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.RachelInit)




------------------------- REIKO - TAINTED RACHEL ----------------------------------

local TAINTED_RACHEL = Isaac.GetPlayerTypeByName("Reiko", true)
local CREATION_ID = Isaac.GetItemIdByName("The Gift of Creation")
local game = Game()

---@param player EntityPlayer
function mod:TaintedRachelInit(player)
    if player:GetPlayerType() ~= TAINTED_RACHEL then
        return
    end

    player:SetPocketActiveItem(CREATION_ID, ActiveSlot.SLOT_POCKET, true)

    local pool = game:GetItemPool()
    pool:RemoveCollectible(CREATION_ID)
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.TaintedRachelInit)

local DAMAGE_REI = 0.65
local SPEED_REI = 0.30
local RANGE_REI = 150

function mod:HandleStartingStatsRei(player, flag)
    if player:GetPlayerType() ~= TAINTED_RACHEL then
        return -- End the function early.
    end

    if flag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage * DAMAGE_REI
    end

    if flag == CacheFlag.CACHE_SPEED then
        player.MoveSpeed = player.MoveSpeed + SPEED_REI
    end

    if flag == CacheFlag.CACHE_RANGE then
        player.TearRange = player.TearRange + RANGE_REI
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.HandleStartingStatsRei)




-------MADDIE--------------------

