------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    智慧药剂

    medicine bottle

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_item_wisdom_medicine.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_wisdom_medicine.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_wisdom_medicine.xml" ),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_item_wisdom_medicine")
    inst.AnimState:SetBuild("chemist_item_wisdom_medicine")
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
                    -- print("info  喝下去",inst.prefab)
                    -- if doer.components.health then
                    --     doer.components.health:DoDelta(50)
                    -- end

                    ------------------------------------------------------------
                    ---- 代码来自 book_research_station
                        local player = doer

                        -- player.components.builder:GiveTempTechBonus({SCIENCE = 2, MAGIC = 2, SEAFARING = 2})

                        local fx = SpawnPrefab(player.components.rider ~= nil and player.components.rider:IsRiding() and "fx_book_research_station_mount" or "fx_book_research_station")
                        fx.Transform:SetPosition(player.Transform:GetWorldPosition())
                        fx.Transform:SetRotation(player.Transform:GetRotation())

                        local buff_index = "chemist_yue_ling_buff_reinforcement_wisdom_medicine"
                        while true do
                            local buff_inst = doer:GetDebuff(buff_index)
                            if buff_inst then
                                break
                            end
                            doer:AddDebuff(buff_index,buff_index)
                        end
                    ------------------------------------------------------------
                    
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
                    replica_com:SetBuild("chemist_item_wisdom_medicine")
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
    inst.components.inventoryitem.imagename = "chemist_item_wisdom_medicine"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_item_wisdom_medicine.xml"

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

return Prefab("chemist_item_wisdom_medicine", fn, assets)
