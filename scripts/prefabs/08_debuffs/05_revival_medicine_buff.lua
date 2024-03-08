------------------------------------------------------------------------------------------------------------------------------------------------

local function OnAttached(inst,target) -- 玩家得到 debuff 的瞬间。 穿越洞穴、重新进存档 也会执行。
    inst.entity:SetParent(target.entity)
    inst.Network:SetClassifiedTarget(target)
    local player = inst.entity:GetParent()
    -----------------------------------------------------
    --- 复活事件
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

    -----------------------------------------------------
    -----
        local function button_display_fn()
            local level = player.components.chemist_com_database:Get("drinked_revival_medicine_level") or 1
            if player:HasTag("playerghost") then
                player.components.chemist_com_rpc_event:PushEvent("chemist_revival_medicine_buttons",{
                    level = level,
                    x = 200,
                    y = 10,
                })
            else
                player.components.chemist_com_rpc_event:PushEvent("chemist_revival_medicine_buttons",{
                    level = level,
                    x = -530,
                    y = -270,
                    a = 0.2,
                    info_only = true,
                })
            end
        end
        inst:DoTaskInTime(3,button_display_fn)          ---- 重载后刷新按钮
        inst:ListenForEvent("ms_becameghost",function() ---- 玩家死后刷新按钮
            inst:DoTaskInTime(5,button_display_fn)
        end,player)
    -----------------------------------------------------
        inst:ListenForEvent("chemist_revival_medicine_buttons_click",function()
            local level = player.components.chemist_com_database:Get("drinked_revival_medicine_level") or 1
            inst:PushEvent("revival_active",{
                doer = player,
                level = level,
            })
            inst:Remove()
        end,player)
    -----------------------------------------------------
end

local function OnDetached(inst) -- 被外部命令  inst:RemoveDebuff 移除debuff 的时候 执行
    local player = inst.entity:GetParent()
end

local function OnUpdate(inst)
    local player = inst.entity:GetParent()

end

local function ExtendDebuff(inst)
    -- inst.countdown = 3 + (inst._level:value() < CONTROL_LEVEL and EXTEND_TICKS or math.floor(TUNING.STALKER_MINDCONTROL_DURATION / FRAMES + .5))
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("CLASSIFIED")



    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff.keepondespawn = true -- 是否保持debuff 到下次登陆
    -- inst.components.debuff:SetDetachedFn(inst.Remove)
    inst.components.debuff:SetDetachedFn(OnDetached)
    -- inst.components.debuff:SetExtendedFn(ExtendDebuff)
    -- ExtendDebuff(inst)

    -- inst:DoPeriodicTask(1, OnUpdate, nil, TheWorld.ismastersim)  -- 定时执行任务


    return inst
end

return Prefab("chemist_yue_ling_buff_revival_medicine_medicine", fn)
