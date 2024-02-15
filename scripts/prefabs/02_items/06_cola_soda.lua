------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    可乐

    medicine bottle

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_item_cola_soda.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_cola_soda.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_cola_soda.xml" ),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_item_cola_soda")
    inst.AnimState:SetBuild("chemist_item_cola_soda")
    inst.AnimState:PlayAnimation("idle")
    
    -- inst.pickupsound = "wood"
    inst:AddTag("medicine_bottle")

    -- inst:AddTag("quick_drink")

    MakeInventoryFloatable(inst, "med", 0.1, 0.75)

    inst.entity:SetPristine()


    ---------------------------------------------------------------------------------------------------------
    --- 示例用 喝下去 组件
            if TheWorld.ismastersim then

                inst:AddComponent("chemist_com_drinkable")
                inst.components.chemist_com_drinkable:SetOnDrinkFn(function(inst,doer)
                    inst.components.stackable:Get():Remove()
                    -- print("info  喝下去")
                    -- if doer.components.health then
                    --     doer.components.health:DoDelta(50)
                    -- end

                    local debuff_inst = doer:GetDebuff("chemist_buff_cola_soda_speedup")
                    if debuff_inst == nil then
                        for i = 1, 10, 1 do
                            if doer:AddDebuff("chemist_buff_cola_soda_speedup","chemist_buff_cola_soda_speedup") then
                                break
                            end
                        end
                    end
                    debuff_inst = doer:GetDebuff("chemist_buff_cola_soda_speedup")
                    if debuff_inst == nil then
                        return false
                    end

                    doer.components.chemist_com_database:Set("chemist_buff_cola_soda_speedup.time",480) -- 刷新计时器

                    if doer.components.health then
                        doer.components.health:DoDelta(30)
                    end
                    if doer.components.sanity then
                        doer.components.sanity:DoDelta(30)
                    end
                    if doer.components.hunger then
                        doer.components.hunger:DoDelta(30)
                    end
                    
                    return true
                end)
            end

            inst:DoTaskInTime(0,function()
                local replica_com = inst.replica.chemist_com_drinkable or inst.replica._.chemist_com_drinkable
                if replica_com then
                    replica_com:SetTestFn(function(inst,doer)
                        -- print("info chemist_com_drinkable test ")
                        -- return true
                        return inst.replica.inventoryitem:IsGrandOwner(doer)    --- 在背包里才能使用
                    end)

                    replica_com:SetLayer("horn01")
                    replica_com:SetBuild("chemist_item_cola_soda")
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
    inst.components.inventoryitem.imagename = "chemist_item_cola_soda"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_item_cola_soda.xml"

    inst:AddComponent("stackable")
    -- inst.components.stackable.maxsize = 10

    -------------------------------------------------------------------
    --- 落水影子
        local function shadow_init(inst)
            if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
                inst.AnimState:Hide("SHADOW")
                -- inst.AnimState:PlayAnimation("water")
            else                                
                inst.AnimState:Show("SHADOW")
                -- inst.AnimState:PlayAnimation("idle")
            end
        end
        inst:ListenForEvent("on_landed",shadow_init)
        shadow_init(inst)
    -------------------------------------------------------------------

    -------------------------------------------------------------------
    return inst
end

return Prefab("chemist_item_cola_soda", fn, assets)
