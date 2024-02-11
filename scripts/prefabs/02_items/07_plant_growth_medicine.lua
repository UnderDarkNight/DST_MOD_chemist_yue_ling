------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    植物生长药剂

    medicine bottle

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local function book_gardening_try_growth(target)
        
                
                --helper function for book_gardening
                local function MaximizePlant(inst)
                    if inst.components.farmplantstress ~= nil then
                        if inst.components.farmplanttendable then
                            inst.components.farmplanttendable:TendTo()
                        end
                
                        inst.magic_tending = true
                        local _x, _y, _z = inst.Transform:GetWorldPosition()
                        local x, y = TheWorld.Map:GetTileCoordsAtPoint(_x, _y, _z)
                
                        local nutrient_consumption = inst.plant_def.nutrient_consumption
                        TheWorld.components.farming_manager:AddTileNutrients(x, y, nutrient_consumption[1]*6, nutrient_consumption[2]*6, nutrient_consumption[3]*6)
                    end
                end
                local function trygrowth(inst, maximize)
                    if not inst:IsValid()
                        or inst:IsInLimbo()
                        or (inst.components.witherable ~= nil and inst.components.witherable:IsWithered()) then

                        return false
                    end

                    if inst:HasTag("leif") then
                        inst.components.sleeper:GoToSleep(1000)
                        return true
                    end

                    if maximize then
                        MaximizePlant(inst)
                    end

                    if inst.components.growable ~= nil then
                        -- If we're a tree and not a stump, or we've explicitly allowed magic growth, do the growth.
                        if inst.components.growable.magicgrowable or ((inst:HasTag("tree") or inst:HasTag("winter_tree")) and not inst:HasTag("stump")) then
                            if inst.components.simplemagicgrower ~= nil then
                                inst.components.simplemagicgrower:StartGrowing()
                                return true
                            elseif inst.components.growable.domagicgrowthfn ~= nil then
                                -- The upgraded horticulture book has a delayed start to make sure the plants get tended to first
                                inst.magic_growth_delay = maximize and 2 or nil
                                inst.components.growable:DoMagicGrowth()

                                return true
                            else
                                return inst.components.growable:DoGrowth()
                            end
                        end
                    end

                    if inst.components.pickable ~= nil then
                        if inst.components.pickable:CanBePicked() and inst.components.pickable.caninteractwith then
                            return false
                        end
                        if inst.components.pickable:FinishGrowing() then
                            inst.components.pickable:ConsumeCycles(1) -- magic grow is hard on plants
                            return true
                        end
                    end

                    if inst.components.crop ~= nil and (inst.components.crop.rate or 0) > 0 then
                        if inst.components.crop:DoGrow(1 / inst.components.crop.rate, true) then
                            return true
                        end
                    end

                    if inst.components.harvestable ~= nil and inst.components.harvestable:CanBeHarvested() and inst:HasTag("mushroom_farm") then
                        if inst.components.harvestable:IsMagicGrowable() then
                            inst.components.harvestable:DoMagicGrowth()
                            return true
                        else
                            if inst.components.harvestable:Grow() then
                                return true
                            end
                        end

                    end

                    return false
                end

                return trygrowth(target,true)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_item_plant_growth_medicine.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_plant_growth_medicine.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_plant_growth_medicine.xml" ),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_item_plant_growth_medicine")
    inst.AnimState:SetBuild("chemist_item_plant_growth_medicine")
    inst.AnimState:PlayAnimation("idle")
    
    -- inst.pickupsound = "wood"
    inst:AddTag("medicine_bottle")

    -- inst:AddTag("quick_drink")

    MakeInventoryFloatable(inst, "med", 0.1, 0.75)

    inst.entity:SetPristine()


    ---------------------------------------------------------------------------------------------------------
    --- 物品使用.
        if TheWorld.ismastersim then
            inst:AddComponent("chemist_com_item_use_to")
            inst.components.chemist_com_item_use_to:SetActiveFn(function(inst,target,doer)
                -- print("info chemist_item_plant_growth_medicine use to",target,doer)

                if book_gardening_try_growth(target) then
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

                        return target:HasTag("chemist_tag.plants")

                end)

            end

        end)

    ---------------------------------------------------------------------------------------------------------

    if not TheWorld.ismastersim then
        return inst
    end




    MakeHauntableLaunchAndIgnite(inst)

    ---------------------

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- inst.components.inventoryitem:ChangeImageName("chemist_equipment_chemical_launching_gun")
    inst.components.inventoryitem.imagename = "chemist_item_plant_growth_medicine"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_item_plant_growth_medicine.xml"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 10

    -------------------------------------------------------------------
    --- 落水影子
        -- local function shadow_init(inst)
        --     if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
        --         inst.AnimState:Hide("SHADOW")
        --         -- inst.AnimState:PlayAnimation("water")
        --     else                                
        --         inst.AnimState:Show("SHADOW")
        --         -- inst.AnimState:PlayAnimation("idle")
        --     end
        -- end
        -- inst:ListenForEvent("on_landed",shadow_init)
        -- shadow_init(inst)
    -------------------------------------------------------------------

    -------------------------------------------------------------------
    return inst
end

return Prefab("chemist_item_plant_growth_medicine", fn, assets)
