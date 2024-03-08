------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    三维恢复药剂

    medicine bottle

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_item_revival_medicine_lv_1.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_revival_medicine_lv_1.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_revival_medicine_lv_1.xml" ),
    
    Asset("ANIM", "anim/chemist_item_revival_medicine_lv_2.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_revival_medicine_lv_2.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_revival_medicine_lv_2.xml" ),
    
    Asset("ANIM", "anim/chemist_item_revival_medicine_lv_3.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_revival_medicine_lv_3.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_revival_medicine_lv_3.xml" ),
    
    Asset("ANIM", "anim/chemist_item_revival_medicine_lv_4.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_revival_medicine_lv_4.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_revival_medicine_lv_4.xml" ),
    
    Asset("ANIM", "anim/chemist_item_revival_medicine_lv_5.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_revival_medicine_lv_5.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_revival_medicine_lv_5.xml" ),


}

local function create_fn(level)
    return function()
        local inst = CreateEntity()
    
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
    
        MakeInventoryPhysics(inst)
    
        local prefab_name = "chemist_item_revival_medicine_lv_"..tostring(level)
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

                        doer.components.chemist_com_database:Set("drinked_revival_medicine_level",level)
                        local buff_name = "chemist_yue_ling_buff_revival_medicine_medicine"
                        for i = 1, 10, 1 do
                            doer:RemoveDebuff(buff_name)
                        end
                        while true do
                            local temp_inst = doer:GetDebuff(buff_name)
                            if temp_inst then
                                break
                            end
                            doer:AddDebuff(buff_name,buff_name)
                        end
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
        --- 物品给目标使用.
            if TheWorld.ismastersim then
                inst:AddComponent("chemist_com_item_use_to")
                inst.components.chemist_com_item_use_to:SetActiveFn(function(inst,target,doer)
                    if target:HasTag("playerghost") then
                        inst:PushEvent("revival_active",{
                            doer = target,
                            level = level
                        })
                        inst.components.stackable:Get():Remove()
                        return true
                    end

                    return false
                end)

            end
            inst:DoTaskInTime(0,function()
                
                local replica_com = inst.replica.chemist_com_item_use_to or inst.replica._.chemist_com_item_use_to
                if replica_com then

                    replica_com:SetTestFn(function(inst,target,doer)
                            return target and target:HasTag("playerghost")
                    end)
                    replica_com:SetSGAction("give")
                    replica_com:SetText(inst.prefab,STRINGS.ACTIONS.CAST_POCKETWATCH.REVIVER)

                end

            end)

        ---------------------------------------------------------------------------------------------------------
        --- 复活事件
            if TheWorld.ismastersim then
                inst:ListenForEvent("revival_active",function(_,_table)
                    local doer = _table.doer
                    local level = _table.level or 1
                    if not doer:HasTag("playerghost") then
                        return
                    end
        
                    local temp_inst = CreateEntity()
                    temp_inst:ListenForEvent("ms_respawnedfromghost",function()
                                        local percent_by_levels = {
                                            [1] = 0.2,
                                            [2] = 0.4,
                                            [3] = 0.6,
                                            [4] = 0.8,
                                            [5] = 1.0,
                                        }
                                        local ret_percent = percent_by_levels[level] or 0.2
        
                                        ---- hunger
                                            if doer.components.hunger then
                                                doer.components.hunger:SetPercent(ret_percent,true)
                                            end
                                        ---- sanity
                                            if doer.components.sanity then
                                                doer.components.sanity:SetPercent(ret_percent,true)
                                            end
                                        ---- health
                                            if doer.components.health then
                                                doer.components.health:SetPercent(ret_percent,true)
                                            end
                                        ---- 移除临时inst
                                            temp_inst:Remove()
                    end,doer)
        
                    ----- 无敌
                        if doer.components.combat then
                            local damage_mult_inst = CreateEntity()
                            doer.components.combat.externaldamagetakenmultipliers:SetModifier(damage_mult_inst,0)
                            local time = 10*level
                            if TUNING.CHEMIST_YUE_LING_DEBUGGING_MODE then
                                time = time*2
                            end
                            doer:DoTaskInTime(time,function()
                                doer.components.combat.externaldamagetakenmultipliers:RemoveModifier(damage_mult_inst)
                                damage_mult_inst:Remove()
                            end)
        
                        end                        
                    -----
                        doer:PushEvent("respawnfromghost", { source = inst })
                end)

            end
        ---------------------------------------------------------------------------------------------------------
    
        if not TheWorld.ismastersim then
            return inst
        end
    
    
    
    
        MakeHauntableLaunchAndIgnite(inst)
        inst.components.hauntable.onhaunt = function(inst,doer)
            if inst and doer and doer:HasTag("playerghost") then
                inst:PushEvent("revival_active",{
                    doer = doer,
                    level = level,
                })
                inst.components.stackable:Get():Remove()
            end
        end
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


return Prefab("chemist_item_revival_medicine_lv_1", create_fn(1), assets),
            Prefab("chemist_item_revival_medicine_lv_2", create_fn(2), assets),
            Prefab("chemist_item_revival_medicine_lv_3", create_fn(3), assets),
            Prefab("chemist_item_revival_medicine_lv_4", create_fn(4), assets),
            Prefab("chemist_item_revival_medicine_lv_5", create_fn(5), assets)
