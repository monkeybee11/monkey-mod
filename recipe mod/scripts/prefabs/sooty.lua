local assets=                              
{
    Asset("ANIM", "anim/sooty.zip"),
    Asset("ANIM", "anim/swap_sooty.zip"),
 
    Asset("ATLAS", "images/inventoryimages/sooty.xml"),
    Asset("IMAGE", "images/inventoryimages/sooty.tex"),
} TheNet:Say("1") -- this dose a thing im not sure what
prefabs = {
    "sooty",
	"torchfire",
} TheNet:Say("2")
local function onfinished(inst)
    inst:Remove()
end  TheNet:Say("3") -- this dose a thing im not sure what

local function onopen(inst)
end TheNet:Say("4")

local function onclose(inst)
end  TheNet:Say("5")

local function LightBattery(item)
	return item:HasTag("lightbattery")
end  TheNet:Say("6")

local function FindBattery(inst, fn)
    return inst.components.container:FindItem(fn)
end

local function lightbattery(inst)
end

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_sooty", "sooty") -- this is kinda a folder parth swap_object = exported folder > swap_prefab > prefab
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	if inst._lightbattery ~= lightbattery then TheNet:Say("check battery 1") -- its only checking for this on world load up ...y
	if lightbattery ~= nil then
		if inst._lightbattery == nil then TheNet:Say("ive got a battery") -- its only checking for this on world load up ...y
			inst.Light:Enable(true)
			end
		end
	elseif inst._lightbattery ~= nil then
		inst.Light:Enable(false)
end
	inst._lightbattery = lightbattery
	TheNet:Say("OnEquip work")
end   -- this dose a thing im not sure what think it alowes to to go in to the hand slot
 
local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end   -- this dose a thing im not sure what think it alowes it to leave the hand slot


local function fn(sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddLight()
	inst.Light:SetRadius(2.5)
	inst.Light:SetIntensity(.8)
	inst.Light:SetFalloff(.4)
    inst.Light:SetColour(180 / 255, 195 / 255, 150 / 255)
	inst.Light:Enable(true)

    inst.entity:AddTransform()    -- this dose a thing im not sure what
    inst.entity:AddAnimState()  -- this dose a thing im not sure what
    inst.entity:AddNetwork()  -- this dose a thing im not sure what
    
    MakeInventoryPhysics(inst)   -- this dose a thing im not sure what
     
    anim:SetBank("sooty")  -- this dose a thing im not sure what
    anim:SetBuild("sooty")  -- this dose a thing im not sure what
    anim:PlayAnimation("idle")  -- this dose a thing im not sure what

    if not TheWorld.ismastersim then
        return inst
    end  -- this dose a thing im not sure what
    inst.entity:SetPristine()  -- this dose a thing im not sure what
 
    inst:AddComponent("inspectable")  -- this dose a thing im not sure what think it alowes a player to inspect the item
     
    inst:AddComponent("inventoryitem")  -- this dose a thing im not sure what
    inst.components.inventoryitem.imagename = "sooty"  -- this dose a thing im not sure what think this is the pic it sues for inventory
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sooty.xml"  -- this dose a thing im not sure what
     
    inst:AddComponent("equippable")  -- this dose a thing im not sure what think this makes the eqping work
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("treasurechest")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

	inst.components.equippable.dapperness = TUNING.DAPPERNESS_HUGE -- this makes it oso dapper
 
    return inst
end TheNet:Say("8")  -- this is the end
return  Prefab("common/inventory/sooty", fn, assets, prefabs)   -- this dose a thing im not sure what