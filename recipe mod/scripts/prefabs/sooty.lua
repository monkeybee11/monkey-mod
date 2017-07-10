local assets=
{ 
    Asset("ANIM", "anim/sooty.zip"),
    Asset("ANIM", "anim/swap_sooty.zip"), 

    Asset("ATLAS", "images/inventoryimages/sooty.xml"),
    Asset("IMAGE", "images/inventoryimages/sooty.tex"),
}

local prefabs = 
{
}

STRINGS.NAMES.SOOTY = "sooty"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOOTY = "monkeys favrout teddy"

local function fn(colour)

    local function OnEquip(inst, owner) 
        owner.AnimState:OverrideSymbol("swap_object", "swap_sooty", "sooty")
        owner.AnimState:Show("ARM_carry") 
        owner.AnimState:Hide("ARM_normal") 
    end

    local function OnUnequip(inst, owner) 
        owner.AnimState:Hide("ARM_carry") 
        owner.AnimState:Show("ARM_normal") 
    end

    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("sooty")
    anim:SetBuild("sooty")
    anim:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "sooty"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sooty.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE

    return inst
end

return  Prefab("common/inventory/sooty", fn, assets, prefabs)
