local mod = RegisterMod("VariousStuffMod",1)

function mod:item_effect(...)
    local player = Isaac.GetPlayer(0)
    local PoopWispNum = math.random(1, 7)
    local POOP_WISP = CollectibleType.COLLECTIBLE_BUTT_BOMBS ---WISP TO SPAWN
    local POOP_WISP_EXTRA = CollectibleType.COLLECTIBLE_POOP ---EXTRA WISP (ONLY IF PLAYER HAS TAROT CLOTH)

    if player:HasCollectible(VSMCollectibles.SPIRITUAL_CRAP) then
       
    if PoopWispNum == 1 then
        POOP_WISP = CollectibleType.COLLECTIBLE_BUTT_BOMBS ---WISP PRINCIPAL
        POOP_WISP_EXTRA = CollectibleType.COLLECTIBLE_BROWN_NUGGET ---WISP EXTRA (TAROT CLOTH)
    elseif PoopWispNum == 2 then
        POOP_WISP = CollectibleType.COLLECTIBLE_E_COLI---WISP PRINCIPAL
        POOP_WISP_EXTRA = CollectibleType.COLLECTIBLE_POOP ---WISP EXTRA (TAROT CLOTH)
    elseif PoopWispNum == 3 then
        POOP_WISP = CollectibleType.COLLECTIBLE_SKATOLE---WISP PRINCIPAL
        POOP_WISP_EXTRA = CollectibleType.COLLECTIBLE_POOP ---WISP EXTRA (TAROT CLOTH)
    elseif PoopWispNum == 4 then
        POOP_WISP = CollectibleType.COLLECTIBLE_NUMBER_TWO---WISP PRINCIPAL
        POOP_WISP_EXTRA = CollectibleType.COLLECTIBLE_BROWN_NUGGET ---WISP EXTRA (TAROT CLOTH)
    elseif PoopWispNum == 5 then
        POOP_WISP = CollectibleType.COLLECTIBLE_HALLOWED_GROUND---WISP PRINCIPAL
        POOP_WISP_EXTRA = CollectibleType.COLLECTIBLE_FLUSH ---WISP EXTRA (TAROT CLOTH)
    elseif PoopWispNum == 6 then
        POOP_WISP = CollectibleType.COLLECTIBLE_DIRTY_MIND---WISP PRINCIPAL
        POOP_WISP_EXTRA = CollectibleType.COLLECTIBLE_BROWN_NUGGET ---WISP EXTRA (TAROT CLOTH)
    elseif PoopWispNum == 7 then
        POOP_WISP = CollectibleType.COLLECTIBLE_MONTEZUMAS_REVENGE ---WISP PRINCIPAL
        POOP_WISP_EXTRA = CollectibleType.COLLECTIBLE_FLUSH ---WISP EXTRA (TAROT CLOTH)
    end

    if player:HasCollectible(CollectibleType.COLLECTIBLE_TAROT_CLOTH) == false then ---SI ISAAC NO TIENE TAROT CLOTH = SPAWNEA 1 WISP

        Isaac.GetPlayer(0):AddItemWisp(POOP_WISP, player.Position, false)

    elseif player:HasCollectible(CollectibleType.COLLECTIBLE_TAROT_CLOTH) then ---SI ISAAC TIENE TAROT CLOTH = SPAWNEA 2 WISP

        Isaac.GetPlayer(0):AddItemWisp(POOP_WISP, player.Position, false)
        Isaac.GetPlayer(0):AddWisp(POOP_WISP_EXTRA, player.Position, false)

    end
end
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.item_effect)




