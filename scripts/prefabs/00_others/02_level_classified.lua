------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    挂载 等级 net_vars 用的 inst

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("CLASSIFIED")
    inst:AddTag("chemist_other_level_classified")
    inst.entity:SetPristine()

    --------------------------------------------------------------------------------------------------------------
    ----- setup    
        inst.__net_classified_entity_target = net_entity(inst.GUID,"chemist_other_level_classified.setup","net_setup")
        inst:ListenForEvent("net_setup",function()
            local target = inst.__net_classified_entity_target:value()
            -- print("info classified setup 2 target",target)
            local replica_com = target.replica.chemist_com_level_sys or target.replica._.chemist_com_level_sys
            if replica_com then
                replica_com.classified = inst
            else
                inst:DoTaskInTime(FRAMES,function()
                    inst:PushEvent("net_setup")
                end)
            end
            if TheWorld.ismastersim and target then
                inst.entity:SetParent(target.entity)
            end
            inst.parent = target
        end)
    --------------------------------------------------------------------------------------------------------------
    ------
        inst.__current_level = net_shortint(inst.GUID,"current_level","data_refresh")
        inst.__max_level = net_shortint(inst.GUID,"max_level","data_refresh")
        inst.__current_exp = net_shortint(inst.GUID,"current_exp","data_refresh")
        inst.__next_level_exp = net_shortint(inst.GUID,"next_level_exp","data_refresh")
        
        inst:ListenForEvent("data_refresh",function()

            local current_level = inst.__current_level:value()
            local max_level = inst.__max_level:value()
            local current_exp = inst.__current_exp:value()
            local next_level_exp = inst.__next_level_exp:value()

            -- local player = inst.parent
            -- local replica_com = player and ( player.replica.chemist_com_level_sys or player.replica._.chemist_com_level_sys )
            -- if replica_com then

            --     replica_com:SetCurrentLevel(current_level)
            --     replica_com:SetMaxLevel(max_level)
            --     replica_com:SetCurrentExp(current_exp)
            --     replica_com:SetNextLevelExp(next_level_exp)

            -- end

            if not TheNet:IsDedicated() and TUNING.CHEMIST_YUE_LING_DEBUGGING_MODE then
                print("info level_classified  Current:",current_level,"Max:",max_level,"Exp:",current_exp,"NextEXP:",next_level_exp)
            end

        end)
    --------------------------------------------------------------------------------------------------------------

    if not TheWorld.ismastersim then
        return inst
    end


    inst:DoTaskInTime(0,function()
        if not inst.Ready then
            inst:Remove()
        end
    end)

    inst:ListenForEvent("Setup",function(_,target)
        inst.Ready = true
        inst.__net_classified_entity_target:set(target)
    end)

    return inst
end

return Prefab("chemist_other_level_classified", fn)
