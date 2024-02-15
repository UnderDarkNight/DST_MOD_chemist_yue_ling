------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    攻击力倍增药剂

    medicine bottle

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_item_attack_power_multiplier_medicine_lv_1.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_1.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_1.xml" ),
    
    Asset("ANIM", "anim/chemist_item_attack_power_multiplier_medicine_lv_2.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_2.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_2.xml" ),
    
    Asset("ANIM", "anim/chemist_item_attack_power_multiplier_medicine_lv_3.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_3.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_3.xml" ),
    
    Asset("ANIM", "anim/chemist_item_attack_power_multiplier_medicine_lv_4.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_4.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_4.xml" ),
    
    Asset("ANIM", "anim/chemist_item_attack_power_multiplier_medicine_lv_5.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_5.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_5.xml" ),


}

local function create_fn(level)
    return function()
        local inst = CreateEntity()
    
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
    
        MakeInventoryPhysics(inst)
    
        local prefab_name = "chemist_item_attack_power_multiplier_medicine_lv_"..tostring(level)
        inst.AnimState:SetBank(prefab_name)
        inst.AnimState:SetBuild(prefab_name)
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
                        ----------------------------------------------------------------------
                        ---- 添加BUFF、刷新计时器  chemist_yue_ling_buff_attack_power_multiplier_medicine
                            --- 伤害倍数 +20% / +40% / +60% / +80% / +100%
                            local mult_with_level = {
                                [1] = 0.2,
                                [2] = 0.4,
                                [3] = 0.6,
                                [4] = 0.8,
                                [5] = 1.0,
                            }
                            local buff_prefab = "chemist_yue_ling_buff_attack_power_multiplier_medicine"
                            -- local buff_inst = doer:Get
                            for i = 1, 30, 1 do ----- 移除已有BUFF，为了保险，多做几次
                                -- doer:RemoveDebuff(buff_prefab)
                                local temp_debuff_inst = doer:GetDebuff(buff_prefab)
                                if temp_debuff_inst then
                                    temp_debuff_inst:Remove()
                                end
                            end
                            ----- 倍增系数
                                local ret_mult = (mult_with_level[level] or 0.2)
                                if not doer:HasTag("chemist_yue_ling") then
                                    ret_mult = ret_mult*0.5
                                end
                                ret_mult = ret_mult + 1

                            local time = TUNING.CHEMIST_YUE_LING_DEBUGGING_MODE and 60 or 300
                            doer.components.chemist_com_database:Set(buff_prefab..".timer" , time)
                            doer.components.chemist_com_database:Set(buff_prefab..".mult" , ret_mult)

                            while true do
                                if doer:AddDebuff(buff_prefab,buff_prefab) then
                                    break
                                end
                            end
                        ----------------------------------------------------------------------
                        return true
                    end)
                end
    
                inst:DoTaskInTime(0,function()
                    local replica_com = inst.replica.chemist_com_drinkable or inst.replica._.chemist_com_drinkable
                    if replica_com then
                        replica_com:SetTestFn(function(inst,doer)
                            return inst.replica.inventoryitem:IsGrandOwner(doer)    --- 在背包里才能使用
                        end)
    
                        replica_com:SetLayer("horn01")
                        -- replica_com:SetBuild("chemist_item_cola_soda")
                        replica_com:SetBuild(prefab_name)
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
        inst.components.inventoryitem.imagename = prefab_name
        inst.components.inventoryitem.atlasname = "images/inventoryimages/"..prefab_name..".xml"
    
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
end


return Prefab("chemist_item_attack_power_multiplier_medicine_lv_1", create_fn(1), assets),
            Prefab("chemist_item_attack_power_multiplier_medicine_lv_2", create_fn(2), assets),
            Prefab("chemist_item_attack_power_multiplier_medicine_lv_3", create_fn(3), assets),
            Prefab("chemist_item_attack_power_multiplier_medicine_lv_4", create_fn(4), assets),
            Prefab("chemist_item_attack_power_multiplier_medicine_lv_5", create_fn(5), assets)
