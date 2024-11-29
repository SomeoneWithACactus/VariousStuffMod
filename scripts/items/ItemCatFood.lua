local mod = RegisterMod("VariousStuffMod",1)
local lastRoomValue = nil

function mod:item_effect(currentPlayer)
    local player = Isaac.GetPlayer(0)
    local room = Game():GetRoom()

    if player:HasCollectible(VSMCollectibles.CATS_FOOD)==true then
        pos = Vector(player.Position.X, player.Position.Y) ---Posicion del Jugador
        vel = Vector(0, 0) ---idk
        num = 3 ---Numero de Moscas
            if lastRoomValue ~= room:GetDecorationSeed() and room:IsFirstVisit() then
                local roomEntities = Isaac.GetRoomEntities()
                for _, entity in ipairs(roomEntities) do
                    if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() then
                        lastRoomValue = room:GetDecorationSeed()
                        player:AddBlueFlies(num, pos,player)
                        num = 0
                    end
                end
            end 
    end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.item_effect, EntityType.ENTITY_PLAYER)
