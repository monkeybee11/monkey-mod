-- In a prefab file, you need to list all the assets it requires.
-- These can be either standard assets, or custom ones in your mod
-- folder.
local Assets =
{
	Asset("ANIM", "anim/sooty.zip"),
    Asset("ANIM", "anim/swap_sooty.zip"), --some 1 tell monkeys brain to stop adding "E" to "anim"
	
	Asset("ATLAS", "images/inventoryimages/sooty.xml"), 
    Asset("IMAGE", "images/inventoryimages/sooty.tex"), 
}
--override symbols
local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "sooty", "swap_object")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
	owner.AnimState:ClearOverrideSymbol("swap_object")
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
end
-- Write a local function that creats, customizes, and returns an instance of the prefab.
local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("sooty")
    inst.AnimState:SetBuild("swap_sooty")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sooty"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sooty.xml"

	inst:AddComponent("inspectable")
	
    local function OnEquip(inst, owner)
	
    owner.AnimState:OverrideSymbol("swap_object", "sooty", "swap_object")
		
        owner.AnimState:Show("ARM_carry") 
        owner.AnimState:Hide("ARM_normal") 
		
    end

    local function OnUnequip(inst, owner) 
	
        owner.AnimState:Hide("ARM_carry") 
        owner.AnimState:Show("ARM_normal") 
		
    end
	
	
    
    return inst
end

-- Add some strings for this item
STRINGS.NAMES.SOOTY = "sooty"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOOTY = "monkeys favrout bear"

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sooty")
    inst.AnimState:SetBuild("sooty")


    inst.entity:SetPristine()
	
	inst:AddComponent("sanityaura")
	inst.components.sanityaura.aura = TUNING.SANITYAURA_SMALL

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "sooty"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sooty.xml"

	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.equipstack = true
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE

    return inst
end
	
-- Finally, return a new prefab with the construction function and assets.
return Prefab( "common/inventory/sooty", fn, Assets, prefabs)