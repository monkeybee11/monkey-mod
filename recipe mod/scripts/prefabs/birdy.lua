local assets=    --birdy is ment to be a item u drop on the ground and it attracts birds and at some point plays a sound
{
     Asset("ANIM", "anim/birdy.zip"),
	 
	 Asset("ATLAS", "images/inventoryimages/birdy.xml"),
	 Asset("IMAGE", "images/inventoryimages/birdy.tex"),
}
prefabs = {
     "birdy",
}
-- the topocket and toground was copyed from bernie_inactive.lua  the lines inside the stuff inside the function was copyed from feather hat in the hats.lua everything else was coppyed from sooty.lua
local function onfinished(inst)  -- think this is what tells the game what to do when picking up and droping birdy
    inst:Remove()
end

local function topocket(inst, owner) -- think this makes it stop spawning birds when u pick it up
	local attractor = owner.components.birdattractor
        if attractor then
            attractor.spawnmodifier:RemoveModifier(inst)

            local birdspawner = TheWorld.components.birdspawner
            if birdspawner ~= nil then
                birdspawner:ToggleUpdate(true)
            end
        end
end

local function toground(inst) -- think this makes it spawn birds when u drop it on the ground
        local attractor = owner.components.birdattractor
        if attractor then
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_MAXDELTA_FEATHERHAT, "maxbirds")
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_FEATHERHAT.MIN, "mindelay")
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_FEATHERHAT.MAX, "maxdelay")
            
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
	
	anim:SetBlank("birdy")
	anim:SetBuild("birdy")
	anim:PlayAnimation("idle")
	
	           if not TheWorld.ismastersim then
		    return inst
		   end
		    inst.entity:SetPristine()
			
	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "birdy"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/birdy.xml"
	
    return inst
end
return Prefab("common/inventory/birdy", fn, assets, prefabs)
