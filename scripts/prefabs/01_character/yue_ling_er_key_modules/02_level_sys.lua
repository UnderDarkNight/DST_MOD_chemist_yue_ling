--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[


    TUNING[string.upper("chemist_yue_ling").."_HUNGER"] = 30
    TUNING[string.upper("chemist_yue_ling").."_SANITY"] = 80
    TUNING[string.upper("chemist_yue_ling").."_HEALTH"] = 30


]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end

    local function level_refresh()
        local level = inst.components.chemist_com_level_sys:Get_Level()
        --------------------------------------------------------------------------------
        --
            -- print("info 等级更新 到",level)
        --------------------------------------------------------------------------------
        --- 三维刷新(每个级别 + 1点)
            local base_hunger = TUNING[string.upper("chemist_yue_ling").."_HUNGER"]
            local base_sanity = TUNING[string.upper("chemist_yue_ling").."_SANITY"]
            local base_health = TUNING[string.upper("chemist_yue_ling").."_HEALTH"]

            inst.components.hunger.max = base_hunger + level
            inst.components.sanity.max = base_sanity + level
            inst.components.health.maxhealth = base_health + level

            inst.components.hunger:DoDelta(1)
            inst.components.sanity:DoDelta(1)
            inst.components.health:DoDelta(1)
        --------------------------------------------------------------------------------
        --- 100 + 制作减半
            if level >= 100 then
                inst.components.builder.ingredientmod = 0.5
            end
        --------------------------------------------------------------------------------
        --- 
            
        --------------------------------------------------------------------------------



    end

    inst:AddComponent("chemist_com_level_sys")
    inst.components.chemist_com_level_sys:Add_Level_Changed_Fn(level_refresh)

    inst.components.chemist_com_level_sys:SetOnLoadFn(level_refresh)

end