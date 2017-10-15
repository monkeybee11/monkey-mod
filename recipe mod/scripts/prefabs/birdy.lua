local assets=
{
    Asset("ANIM", "anim/birdy.zip"),
	Asset("SOUND", "sound/birdy_bank00.fsb"),
	Asset("ATLAS", "images/inventoryimages/birdy.xml"),
	Asset("IMAGE", "images/inventoryimages/birdy.tex"),
}
prefabs = {
     "birdy",
} 
local function onfinished(inst) TheNet:Say("1",false)
    inst:Remove() TheNet:Say("2",false)
end TheNet:Say("3",false)

local function toground(inst) TheNet:Say("4",false) --work
    local attractor = TheWorld.components.birdattractor TheNet:Say("5",false) --work
        if attractor then TheNet:Say("6",false)
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_MAXDELTA_BIRDY, "maxbirds") TheNet:Say("7",false)
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_BIRDY.MIN, "mindelay") TheNet:Say("8",false)
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_BIRDY.MAX, "maxdelay") TheNet:Say("9",false)
            
            local birdspawner = TheWorld.components.birdspawner TheNet:Say("10",false)
            if birdspawner ~= nil then TheNet:Say("11",false)
                birdspawner:ToggleUpdate(true) TheNet:Say("12",false)
            end TheNet:Say("13",false)
    end TheNet:Say("14",false) --work
end TheNet:Say("15",false)

local function topocket(inst) TheNet:Say("16",false) -- work
	local attractor = TheWorld.components.birdattractor TheNet:Say("17",false) -- work
        if attractor then TheNet:Say("18",false)
            attractor.spawnmodifier:RemoveModifier(inst) TheNet:Say("19",false)

            local birdspawner = TheWorld.components.birdspawner TheNet:Say("20",false)
            if birdspawner ~= nil then TheNet:Say("21",false)
                birdspawner:ToggleUpdate(true) TheNet:Say("22",false)
            end TheNet:Say("24",false)
    end TheNet:Say("25",false)  --work
end TheNet:Say("26",false)

local function fn(sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)
    toground(inst)
	
	MakeInventoryPhysics(inst)
	 
	anim:SetBank("birdy")
	anim:SetBuild("birdy")
	anim:PlayAnimation("idle")
	
	           if not TheWorld.ismastersim then
		    return inst
		   end
		    inst.entity:SetPristine()
			inst.sounds =
			{
			birdy_tweet = "dontstarve/birdy_bank00/birdy_tweet",
			}
			
	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "birdy"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/birdy.xml"
	
	return inst
end
return Prefab("common/inventory/birdy", fn, assets, prefabs)