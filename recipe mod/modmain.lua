local STRINGS = GLOBAL.STRINGS

--[[

This mod shows how to load custom prefabs and assets so that they are usable
by the game.

--]]
GLOBAL.STRINGS.SOOTY = "sooty"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOOTY = "monkeys favrout teddy bear"

-- The PrefabFiles list is the list of all the files in your <modname>/scripts/prefabs folder
-- that you want to load prefabs from
PrefabFiles = {
	"sooty",
}


-- Import things we like into our mod's own global scope, so we don't have 
-- to type "GLOBAL." every time want to use them.
SpawnPrefab = GLOBAL.SpawnPrefab

local assets=
{
	
    Asset("ATLAS", "images/inventoryimages/sooty.xml"),
    Asset("IMAGE", "images/inventoryimages/sooty.tex"),
	
}

AddSimPostInit(SimInit )
