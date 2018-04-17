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

local function toground(inst) -- this makes birds spawn as offten as wearing a feather hat when on the ground
	local birdspawner = TheWorld.components.birdspawner
    if not TheWorld.ismastersim then
            return inst
    end
    if birdspawner ~= nil then
            birdspawner:SetSpawnTimes({min=2, max=10})
            birdspawner:SetMaxBirds(7)
    end
end

local function topocket(inst) -- this makes the spawn rate return to normal when birdy is picked up
	local birdspawner = TheWorld.components.birdspawner
    if not TheWorld.ismastersim then
            return inst
    end
    if birdspawner ~= nil then
            birdspawner:SetSpawnTimes({min=5, max=15})
            birdspawner:SetMaxBirds(4)
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