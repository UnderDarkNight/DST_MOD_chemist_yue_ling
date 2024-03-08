------------------------------------------------------------------------------------------------------------------------------------------------

local function OnAttached(inst,target) -- 玩家得到 debuff 的瞬间。 穿越洞穴、重新进存档 也会执行。
    inst.entity:SetParent(target.entity)
    inst.Network:SetClassifiedTarget(target)
    local player = inst.entity:GetParent()
    -----------------------------------------------------
    -- local old_mult = player.components.builder.ingredientmod or 1
    -- player.components.builder.ingredientmod = 0
    player:DoTaskInTime(1,function()        
    
                if player.components.builder.freebuildmode then
                    return
                end
                player.components.builder:GiveAllRecipes()

                local build_event_fn = function()
                    -- player.components.builder.ingredientmod = old_mult
                    if player.components.builder.freebuildmode then
                        player.components.builder:GiveAllRecipes()
                    end

                    inst:Remove()
                    if TUNING.CHEMIST_YUE_LING_DEBUGGING_MODE then
                        print("智慧药剂BUFF Removed")
                    end
                end
                inst:ListenForEvent("buildstructure", build_event_fn,player)
                inst:ListenForEvent("builditem", build_event_fn,player)

                if TUNING.CHEMIST_YUE_LING_DEBUGGING_MODE then
                    print("智慧药剂BUFF Added")
                end

    end)
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

return Prefab("chemist_yue_ling_buff_reinforcement_wisdom_medicine", fn)
