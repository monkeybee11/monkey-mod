local assets=
{
    Asset("ANIM", "anim/sooty.zip"),
    Asset("ANIM", "anim/swap_sooty.zip"),
 
    Asset("ATLAS", "images/inventoryimages/sooty.xml"),
    Asset("IMAGE", "images/inventoryimages/sooty.tex"),
}  -- this dose a thing im not sure what

local light_assets =
{
    Asset("ANIM", "anim/hutch_lightfx_base.zip"),
}

prefabs = {
    "sooty",
}
local function onfinished(inst)
    inst:Remove()
end   -- this dose a thing im not sure what
	local function OnEquip(inst, owner, LightBattery)
        owner.AnimState:OverrideSymbol("swap_object", "swap_sooty", "sooty") -- this is kinda a folder parth swap_object = exported folder > swap_prefab > prefab
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
		inst.components.container:Open(owner)			
end   -- this dose a thing im not sure what think it alowes to to go in to the hand slot
 
local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    inst.components.container:Close(owner)
end   -- this dose a thing im not sure what think it alowes it to leave the hand slot
	
	local slotpos = {}

for y = 0, 3 do
	table.insert(slotpos, Vector3(82, -y*75 + 114 ,0))
	table.insert(slotpos, Vector3(82 +75, -y*75 + 114 ,0))
end
local containers = require "containers"

local oldwidgetsetup = containers.widgetsetup
containers.widgetsetup = function(container, prefab)
    if not prefab and container.inst.prefab == "sooty" then
        prefab = "treasurechest"
    end
    oldwidgetsetup(container, prefab)
 end


--------------------------------------------------------------------------------------------------
--lights
--------------------------------------------------------------------------------------------------
--sooty with light
local LIGHT_RADIUS = 2.5
local LIGHT_INTENSITY = .8
local LIGHT_FALLOFF = .4

local NORMAL_LIGHT_COLOUR = { 180 / 255, 195 / 255, 150 / 255 }

local function SetNormalLight(inst)
    inst.Light:SetRadius(LIGHT_RADIUS)
    inst.Light:SetIntensity(LIGHT_INTENSITY)
    inst.Light:SetFalloff(LIGHT_FALLOFF)
    inst.Light:SetColour(unpack(NORMAL_LIGHT_COLOUR))
end

---------------------------------------------------------------------------------------------------

local function LightBattery(item)
    return item:HasTag("lightbattery")
end

local function FindBattery(inst, fn)
    return inst.components.container:FindItem(fn)
end

local function CheckBattery(inst)
    local lightbattery = FindBattery(inst, LightBattery)
    if inst._lightbattery ~= lightbattery then
        if lightbattery ~= nil then
            if inst._lightbattery == nil then
                inst.Light:Enable(true)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/lantern_on")
            end
        elseif inst._lightbattery ~= nil then
            inst.SoundEmitter:PlaySound("dontstarve/wilson/lantern_off")
            inst.Light:Enable(false)
        end
        inst._lightbattery = lightbattery
    end
end

local function fn(sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()


    inst.entity:AddTransform()    -- this dose a thing im not sure what
    inst.entity:AddAnimState()  -- this dose a thing im not sure what
    inst.entity:AddLightWatcher()
    inst.entity:AddLight()
    inst.entity:AddNetwork()  -- this dose a thing im not sure what
	

    MakeInventoryPhysics(inst)   -- this dose a thing im not sure what
     
    anim:SetBank("sooty")  -- this dose a thing im not sure what
    anim:SetBuild("sooty")  -- this dose a thing im not sure what
    anim:PlayAnimation("idle")  -- this dose a thing im not sure what
	
    inst:AddComponent("container")
  
    inst.components.container:WidgetSetup("treasurechest")
	
    inst.Light:SetRadius(LIGHT_RADIUS)
    inst.Light:SetIntensity(LIGHT_INTENSITY)
    inst.Light:SetFalloff(LIGHT_FALLOFF)
    inst.Light:SetColour(unpack(NORMAL_LIGHT_COLOUR))
    inst.Light:Enable(false)

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

	inst.components.equippable.dapperness = TUNING.DAPPERNESS_HUGE -- this makes it oso dapper
 
    return inst
end   -- this is the end
return  Prefab("common/inventory/sooty", fn, assets, prefabs),
    Prefab("hutch_music_light_fx",light_assets)