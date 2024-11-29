local mod = RegisterMod("VariousStuffMod", 1)

VSMCollectibles = {
	ACRYLIUM = Isaac.GetItemIdByName("Acrylium"),
    EVIL_SKULL = Isaac.GetItemIdByName("EVIL SKULL"),
    WHOLE_MILK = Isaac.GetItemIdByName("Whole Milk"),
    SUPER_VEGETA = Isaac.GetItemIdByName("Super Vegeta"),
    CATS_FOOD = Isaac.GetItemIdByName("Cat's Food"),
    D2 = Isaac.GetItemIdByName("D2"),
    GIFT_OF_CREATION = Isaac.GetItemIdByName("The Gift of Creation"),
    SPIRITUAL_CRAP = Isaac.GetItemIdByName("Spiritual Crap"),
    BROKEN_CRYSTAL_BALL = Isaac.GetItemIdByName("Broken Crystal Ball"),
    WATER_VEGETA = Isaac.GetItemIdByName("Water Vegeta"),
    SOUL_SPLITTER = Isaac.GetItemIdByName("Soul Splitter"),
    BEARS_MASK = Isaac.GetItemIdByName("Bear's Mask"),
    STARLIGHT_WINGS = Isaac.GetItemIdByName("Starlight Wings"),
    DEALMAKER = Isaac.GetItemIdByName("Dealmaker")
}

VSMTrinkets = {
	BROKEN_PIN = Isaac.GetTrinketIdByName("Broken Pin"),
    LANCER = Isaac.GetTrinketIdByName("Lancer!"),
    DELIVERY_NUMBER = Isaac.GetTrinketIdByName("Delivery Number"),
}

VSMPickups = {
    FIGURINES = 4787
}

FigurinesSubType = {
    CREATIVITY = 1,
    SURVIVAL = 2,
    ENDURANCE = 3,
}

VSMPocketitems = {
    FIGURE_OF_CREATIVITY = Isaac.GetCardIdByName("Creativity"),
    FIGURE_OF_SURVIVAL = Isaac.GetCardIdByName("Survival"),
    FIGURE_OF_ENDURANCE = Isaac.GetCardIdByName("Endurance"),
}


if EID then
    EID:addCollectible(VSMCollectibles.ACRYLIUM, "Creates a purple puddle of petryifing creep#On Passive:#↑ {{Damage}} +0.45 Damage UP!#↑ {{Tears}} +0.20 Tears UP!#Grants slowing tears while held")
    EID:addCollectible(VSMCollectibles.EVIL_SKULL, "↑ {{Damage}} +1.5 damage UP!#↑ {{BlackHeart}} Grants 2 black hearts takes away one heart container")
    EID:addCollectible(VSMCollectibles.WHOLE_MILK, "↑ {{Tears}} 0.45x Fire delay Multiplier#↓ {{ShotSpeed}} -0.35 Shot Speed DOWN#↓ {{Speed}} -0.35 Speed DOWN")
    EID:addCollectible(VSMCollectibles.SUPER_VEGETA, "↑ {{Damage}} 1.5x Damage Multiplier#↓ {{Speed}} -0.65 Speed DOWN")
    EID:addCollectible(VSMCollectibles.CATS_FOOD, "{{SoulHeart}} Grants 2 Soul Hearts on Pickup#On a new unexplored room, spawns three blue flies")
    EID:addCollectible(VSMCollectibles.D2, "50% Chance of Instakilling every enemy and boss in the room#50% Chance of Instakilling the player")
    EID:addCollectible(VSMCollectibles.GIFT_OF_CREATION, "On Use:#If there is a Charmed Enemy in the room:#It will spawn a friendly charmed enemy based of their own pool of enemies#On Spawn they will create a petryifing creep puddle#If there is a {{BossRoom}} Boss in the room: it will grant a familiar of their own pool for the room!#(All Charmed enemies will die upon entering a new floor)#On Passive:#Grants Charming Tears!")
    EID:addCollectible(VSMCollectibles.SPIRITUAL_CRAP, "Upon using a Card it will spawn a Poop-related Lemegeton Wisp#If the player has {{Collectible451}} Tarot Cloth, it will grant an extra Poop-related Active Item wisp from the Book of Virtues")
    EID:addCollectible(VSMCollectibles.BROKEN_CRYSTAL_BALL, "On use, it has a chance of triggering one of the next effects:#Grant a Broken Heart#Spawn a Zodiac Item#Spawn a Broken Trinket#Use the {{Card44}} Rules Card effect#Use the {{Card74}} Reverse Moon effect")
    EID:addCollectible(VSMCollectibles.WATER_VEGETA, "On a Water Filled Room, it will grant#↑ {{Damage}} +1 damage UP!# {{Speed}} Locks Speed on 2.00")
    EID:addCollectible(VSMCollectibles.SOUL_SPLITTER, "Split your Soul into a Ghost!#It Grants a Broken Heart when going Ghost#On Ghost Form:#↑ {{Damage}} 2x Damage Multiplier#↑ {{Tears}} 0.50x Tears Multiplier#It will bring you back to your regular form upon clearing a Room")
    EID:addCollectible(VSMCollectibles.BEARS_MASK, "Confuses ALL ENEMIES in the Room on Use#↓ {{Range}} Locks your range on 1 while Using it")
    EID:addCollectible(VSMCollectibles.STARLIGHT_WINGS, "When the Player has 8 hearts (Of any kind)#It will grant:#↑ {{Damage}} 2x damage Multiplier!#↑ {{Speed}} Locks Player's Speed on 2.00#!!! If the player get hit while the buff is active, will deny the damage and take away the buff until the next floor")
    EID:addCollectible(VSMCollectibles.DEALMAKER, "On pickup spawns a {{Trinket52}} Counterfeit Penny#Killing enemies will spawn 1 coin#Getting hit will remove 5 coins when the player has less than 20 coins#And 10 when the player has more than 20 coins# !!! Upon entering a new floor all coins will be removed (Spamton Taxes)")

	
	EID:addTrinket(VSMTrinkets.BROKEN_PIN, "On hit, it has a chance of Spawning one of the next defensive Fly Items:#{{Collectible264}} Smart Fly#{{Collectible629}} Bot Fly#{{Collectible365}} Lost Fly#{{Collectible430}} Papa Fly#{{Collectible511}} Angry Fly#{{Collectible581}} Psy Fly")
    EID:addTrinket(VSMTrinkets.LANCER, "Upon entering a new floor,#It will spawn one of the next cards:#{{Card25}} 2 of Spades #{{Card29}} Ace of Spades #{{Card44}} Rules Card")
    EID:addTrinket(VSMTrinkets.DELIVERY_NUMBER, "Upon entering a new floor spawns a Box Beggar")
    
    EID:addCard(VSMPocketitems.FIGURE_OF_CREATIVITY, "Spawns 4 creeps puddles in random positions in the room#!!! Full healt if player has unfilled heart containers#!!! If all Heart containers are filled, will grand one of each heart types")
    EID:addCard(VSMPocketitems.FIGURE_OF_ENDURANCE, "Grants {{Collectible592}} Terra and {{Collectible108}} The Wafer for the room#Spawns a Shockwave in the player's position")
    EID:addCard(VSMPocketitems.FIGURE_OF_SURVIVAL, " ↑ Damage Up#↑ Speed Up#↑ Tears Up#!!! Grants Pointy Rib for the room")
end

VSMMonsters = {
    ANGRIER_FLY = Isaac.GetEntityTypeByName("Angrier Fly"),
    SPIDER_BOX = Isaac.GetEntityTypeByName("Spider Box"),
    FIRE_TOTEM = Isaac.GetEntityTypeByName("Fire Totem"),
}

VSMSlots = {
    BOX_BEGGAR = Isaac.GetEntityTypeByName("Box Beggar"),
}

BeggarState = {
    IDLE = 0,
    PAYNOTHING = 2,
    PAYPRIZE = 3,
    PRIZE = 4,
    TELEPORT = 5
}

VSMSounds = {
    GLASS_CLICK = Isaac.GetSoundIdByName("GLASS_CLICK"),
    BEARMASK_ON = Isaac.GetSoundIdByName("BEAR_MASK_ON"),
    BEARMASK_OFF = Isaac.GetSoundIdByName("BEAR_MASK_OFF"),
    POWER_UP_DB = Isaac.GetSoundIdByName("POWERUP_DB"),
    STARLIGHT_ACTIVATE = Isaac.GetSoundIdByName("STARLIGHT_ACTIVATE"),
    STARLIGHT_GOTHIT = Isaac.GetSoundIdByName("STARLIGHT_GOTHIT"),
    DEALMAKER_BIGSHOT = Isaac.GetSoundIdByName("DEALMAKER_BIGSHOT"),
    DEALMAKER_LAUGHT = Isaac.GetSoundIdByName("DEALMAKER_LAUGHT"),
}

