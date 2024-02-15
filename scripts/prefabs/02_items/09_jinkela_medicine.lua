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

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_item_jinkela_medicine")
    inst.AnimState:SetBuild("chemist_item_jinkela_medicine")
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




    MakeHauntableLaunchAndIgnite(inst)

    ---------------------

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- inst.components.inventoryitem:ChangeImageName("chemist_equipment_chemical_launching_gun")
    inst.components.inventoryitem.imagename = "chemist_item_jinkela_medicine"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_item_jinkela_medicine.xml"

    inst:AddComponent("stackable")
    -- inst.components.stackable.maxsize = 10

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

return Prefab("chemist_item_jinkela_medicine", fn, assets)
