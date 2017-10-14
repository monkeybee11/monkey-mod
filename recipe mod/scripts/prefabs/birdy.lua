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
local function onfinished(inst)
    inst:Remove()
end

local function toground(inst)
    local attractor = TheWorld.components.birdattractor
        if attractor then
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_MAXDELTA_BIRDY, "maxbirds")
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_BIRDY.MIN, "mindelay")
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_BIRDY.MAX, "maxdelay")
            
            local birdspawner = TheWorld.components.birdspawner
            if birdspawner ~= nil then
                birdspawner:ToggleUpdate(true)
            end
    end
end

local function topocket(inst)
	local attractor = TheWorld.components.birdattractor
        if attractor then
            attractor.spawnmodifier:RemoveModifier(inst)

            local birdspawner = TheWorld.components.birdspawner
            if birdspawner ~= nil then
                birdspawner:ToggleUpdate(true)
            end
    end
end

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