------------------------------------------------------------------------------------------------------------------------------------------------
    local assets =
    {
        Asset("ANIM", "anim/chemist_buff__fx_spriter_cola.zip"),
    }
------------------------------------------------------------------------------------------------------------------------------------------------

local function OnAttached(inst,target) -- 玩家得到 debuff 的瞬间。 穿越洞穴、重新进存档 也会执行。
    inst.entity:SetParent(target.entity)
    inst.Network:SetClassifiedTarget(target)
    local player = inst.entity:GetParent()
    -----------------------------------------------------    

        player.components.locomotor:SetExternalSpeedMultiplier(inst, "chemist_buff_cola_soda_speedup", TUNING.CHEMIST_YUE_LING_DEBUGGING_MODE and 2 or 1.2)

        -----------------------------------------------------
        ---- 特效
            local fx_spriter = SpawnPrefab("chemist_buff__fx_spriter")
            inst.fx_spriter = fx_spriter
            fx_spriter:PushEvent("Set",{
                player = player,  --- 跟随目标
                range = 3,           --- 环绕点半径
                point_num = 15,       --- 环绕点
                -- new_pt_time = 0.5 ,    --- 新的跟踪点时间
                -- speed = 8,           --- 强制固定速度
                speed_mult = 2,      --- 速度倍速
                next_pt_dis = 0.5,      --- 触碰下一个点的距离
                speed_soft_delta = 20, --- 软增加
                y = 1.5,
                tail_time = 0.2,
                bank_build = "chemist_buff__fx_spriter_cola",
                bloom_off = true,
                clockwise = math.random(100) < 50,
                scale = 0.7,
                only_follow = TUNING["chemist_yue_ling.Config"].FX_ONLY_FOLLOW,
            })
            inst:ListenForEvent("onremove", function()
                fx_spriter:Remove()
            end)
        -----------------------------------------------------
        ---- 死亡
            player:ListenForEvent("death",function()
                inst.components.debuff:OnDetach()

            end)
        -----------------------------------------------------

    -----------------------------------------------------
end

local function OnDetached(inst) -- 被外部命令  inst:RemoveDebuff 移除debuff 的时候 执行
    local player = inst.entity:GetParent()
    player.components.locomotor:RemovePredictExternalSpeedMultiplier(inst, "chemist_buff_cola_soda_speedup")
    if inst.fx_spriter then
        inst.fx_spriter:Remove()
    end
    inst:Remove()
end

local function OnUpdate(inst)
    local player = inst.entity:GetParent()

    local time = player.components.chemist_com_database:Add("chemist_buff_cola_soda_speedup.time",-1)
    if time <= 0 then
        inst.components.debuff:OnDetach()
    end

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

    inst:DoPeriodicTask(1, OnUpdate, nil, TheWorld.ismastersim)  -- 定时执行任务


    return inst
end

return Prefab("chemist_buff_cola_soda_speedup", fn,assets)
