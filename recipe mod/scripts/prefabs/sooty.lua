local assets=
{
    Asset("ANIM", "anim/sooty.zip"),
    Asset("ANIM", "anim/swap_sooty.zip"),
 
    Asset("ATLAS", "images/inventoryimages/sooty.xml"),
    Asset("IMAGE", "images/inventoryimages/sooty.tex"),
}  -- this dose a thing im not sure what
prefabs = {
    "sooty",
	"torchfire",
}
local function onfinished(inst)
    inst:Remove()
end   -- this dose a thing im not sure what

local function onopen(inst)
end

local function onclose(inst)
end

local function LightBattery(item)
	return item:HasTag("lightbattery")
end
	
local function CreateGroundGlow(inst, rotrate)
    local groundglow = SpawnPrefab("hutch_music_light_fx")
    local scale = (math.random() * .2 + 1.2) * (math.random() < .5 and 1 or -1)
    groundglow.Transform:SetScale(scale, scale, scale)
    groundglow.Follower:FollowSymbol(inst.GUID, "base_point", 0, 0, 0)
    groundglow:InitFX(
        inst,
        {
            rot = math.random(0, 359),
            rotrate = rotrate,
            alpha = math.random(),
            alphadir = math.random() < .5,
            alpharate = math.random() * .02 + .005,
        }
    )
    return groundglow
end
	
	local function CheckBattery(inst)
		local lightbattery = --[[ works for all forms ]] FindBattery(inst, LightBattery)
		
		if inst._lightbattery ~= lightbattery then
			if lightbattery ~= nil then
				if inst._lightbattery == nil then
					for i, fx_prefab in ipairs(inst:GetSkinName() == nil and { "torchfire" } or SKIN_FX_PREFAB[inst:GetSkinName()] or {}) do
					local fx = SpawnPrefab(fx_prefab)
					fx.entity:SetParent(owner.entity)
					fx.entity:AddFollower()
					fx.Follower:FollowSymbol(owner.GUID, "swap_object", 0, fx.fx_offset, 0)

					table.insert(inst.fires, fx)
					inst.Light:Enable(true)
					end
				end
			elseif inst._lightbattery ~= nil then
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
		
    local function OnEquip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_sooty", "sooty") -- this is kinda a folder parth swap_object = exported folder > swap_prefab > prefab
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end   -- this dose a thing im not sure what think it alowes to to go in to the hand slot
 
    local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end   -- this dose a thing im not sure what think it alowes it to leave the hand slot
	
	local function OnLoadPostPass(inst)
		inst:ListenForEvent("itemget", CheckBattery)
		inst:ListenForEvent("itemlose", CheckBattery)
		if POPULATING then
			CheckBattery(inst)
		end
	end
 

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
end   -- this is the end
return  Prefab("common/inventory/sooty", fn, assets, prefabs)   -- this dose a thing im not sure what