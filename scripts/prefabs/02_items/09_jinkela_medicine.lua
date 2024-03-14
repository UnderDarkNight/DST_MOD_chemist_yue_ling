------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    金坷垃药剂

    medicine bottle

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local function fertilize2target(target)
        -- print("info fertilize2target",target)
        -- 给目标上 buff
        -- 检查逻辑放到buff

        local debuff_inst = target:GetDebuff("chemist_buff_plants_can_not_be_barren")
        if debuff_inst == nil then
            for i = 1, 10, 1 do
                if target:AddDebuff("chemist_buff_plants_can_not_be_barren","chemist_buff_plants_can_not_be_barren") then
                    break
                end
            end
        end
        debuff_inst = target:GetDebuff("chemist_buff_plants_can_not_be_barren")
        if debuff_inst == nil then
            return false
        end


        return true
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_item_jinkela_medicine.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_jinkela_medicine.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_jinkela_medicine.xml" ),
}



local prefabs =
{

}

local FERTILIZER_DEFS = require("prefabs/fertilizer_nutrient_defs").FERTILIZER_DEFS


local function GetFertilizerKey(inst)
    return "poop"
end

local function fertilizerresearchfn(inst)
    return inst:GetFertilizerKey()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_item_jinkela_medicine")
    inst.AnimState:SetBuild("chemist_item_jinkela_medicine")
    inst.AnimState:PlayAnimation("idle")

    MakeInventoryFloatable(inst, "med", 0.1, 0.73)
    MakeDeployableFertilizerPristine(inst)

    inst:AddTag("fertilizerresearchable")
    inst:AddTag("fertilizer")
    inst:AddTag("medicine_bottle")


    inst.GetFertilizerKey = GetFertilizerKey

    inst.entity:SetPristine()
    ---------------------------------------------------------------------------------------------------------
    --- 物品使用.
        if TheWorld.ismastersim then
            inst:AddComponent("chemist_com_item_use_to")
            inst.components.chemist_com_item_use_to:SetActiveFn(function(inst,target,doer)
                -- print("info chemist_item_jinkela_medicine use to",target,doer)

                if fertilize2target(target) then
                    inst.components.stackable:Get():Remove()
                    doer.SoundEmitter:PlaySound("dontstarve/common/fertilize")
                    return true
                end

                return false
            end)

        end
        inst:DoTaskInTime(0,function()
            
            local replica_com = inst.replica.chemist_com_item_use_to or inst.replica._.chemist_com_item_use_to
            if replica_com then

                replica_com:SetTestFn(function(inst,target,doer)

                        return ( target:HasTag("chemist_tag.plants") and not target:HasTag("chemist_buff_can_not_be_barren") )

                end)
                replica_com:SetSGAction("give")
                replica_com:SetText(inst.prefab,STRINGS.ACTIONS.FERTILIZE)

            end

        end)

    ---------------------------------------------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "chemist_item_jinkela_medicine"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_item_jinkela_medicine.xml"

    inst:AddComponent("stackable")

    inst:AddComponent("fertilizerresearchable")
    inst.components.fertilizerresearchable:SetResearchFn(fertilizerresearchfn)


    inst.flies = inst:SpawnChild("flies")

    MakeHauntableLaunchAndIgnite(inst)

    ---------------------------------------------------------------------------------
    ---- 
        --[[

            local function fertilizer_ondeploy(inst, pt, deployer)
                local tile_x, tile_z = TheWorld.Map:GetTileCoordsAtPoint(pt:Get())
                local nutrients = inst.components.fertilizer.nutrients
                TheWorld.components.farming_manager:AddTileNutrients(tile_x, tile_z, nutrients[1], nutrients[2], nutrients[3])

                inst.components.fertilizer:OnApplied(deployer)
                if deployer ~= nil and deployer.SoundEmitter ~= nil and inst.components.fertilizer.fertilize_sound ~= nil then
                    deployer.SoundEmitter:PlaySound(inst.components.fertilizer.fertilize_sound)
                end
            end

        ]]--
        MakeDeployableFertilizer(inst)
        inst.components.deployable.ondeploy = function(inst, pt, deployer)
            inst.SoundEmitter:PlaySound("dontstarve/common/fertilize")
            inst.components.stackable:Get():Remove()

            -------------------------------------------------------------------------------------------
            ---- 给作物上buff
                local mid_pt = Vector3(TheWorld.Map:GetTileCenterPoint(pt.x,0,pt.z))
                local musthavetags = {"chemist_tag.plants"}
                local canthavetags = {"chemist_buff_can_not_be_barren","burnt"}
                local ents = TheSim:FindEntities(mid_pt.x, 0, mid_pt.z, 3, musthavetags, canthavetags)
                for k, temp_plant in pairs(ents) do
                    fertilize2target(temp_plant)
                end
            -------------------------------------------------------------------------------------------
            ---- 给田地施肥
                local tile_x, tile_z = TheWorld.Map:GetTileCoordsAtPoint(mid_pt.x,0,mid_pt.z)
                -- TheWorld.components.farming_manager:SetTileNutrients(tile_x, tile_z,0,0,0)
                TheWorld.components.farming_manager:AddTileNutrients(tile_x, tile_z,100,100,100)

            -------------------------------------------------------------------------------------------
            ---- 添加水分
                TheWorld.components.farming_manager:AddSoilMoistureAtPoint(mid_pt.x, 0, mid_pt.z, 100)
            -------------------------------------------------------------------------------------------

            -- SpawnPrefab("log").Transform:SetPosition(mid_pt.x, 0, mid_pt.z)
        end
    ---------------------------------------------------------------------------------
    return inst
end

return Prefab("chemist_item_jinkela_medicine", fn, assets, prefabs)
