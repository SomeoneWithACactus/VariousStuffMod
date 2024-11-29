local mod = RegisterMod("VariousStuffMod", 1)

function mod:NewFloor(player)

    local player = Isaac.GetPlayer(0)
    local POSITION_PLAYER = Isaac.GetFreeNearPosition(player.Position, 50)

    local PLAYER_MONEY = player:GetNumCoins()

 
    if player:HasTrinket(VSMTrinkets.DELIVERY_NUMBER,true) then
    Isaac.Spawn(VSMSlots.BOX_BEGGAR, 0, 0, POSITION_PLAYER, Vector(0, 0), player) ---SPAWN BOX BEGGAR
    end


end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.NewFloor)
