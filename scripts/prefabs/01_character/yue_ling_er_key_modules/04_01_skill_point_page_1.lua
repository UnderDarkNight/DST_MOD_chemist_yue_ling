--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    技能册第一页

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end

    --- attack_power_multiplier_medicine.button_lv_up              --- 按钮
    --- attack_power_multiplier_medicine.button_lv_max             --- 按钮
    --- attack_power_multiplier_medicine.button_double_lv_up       --- 按钮
    --- attack_power_multiplier_medicine.button_double_lv_max      --- 按钮

    --- attack_power_multiplier_medicine.item_level         --- 药水等级
    --- attack_power_multiplier_medicine.double_level         --- 双倍等级

    --------------------------------------------------------------------------
    ----- 等级
        inst.components.chemist_com_skill_point_sys:AddButtonFn("attack_power_multiplier_medicine.button_lv_up",function()
            local free_points = inst.components.chemist_com_skill_point_sys:GetFreePoints()
            if free_points <= 0 then
                return
            end
            local max = 5

            local current_level = inst.components.chemist_com_skill_point_sys:Add("attack_power_multiplier_medicine.item_level",0)
            if current_level >= max then
                return
            end

            current_level = current_level + 1

            if current_level >= max  then
                current_level = max
            end

            inst.components.chemist_com_skill_point_sys:FreePointDelta(-1)
            inst.components.chemist_com_skill_point_sys:Set("attack_power_multiplier_medicine.item_level",current_level)

        end)

        inst.components.chemist_com_skill_point_sys:AddButtonFn("attack_power_multiplier_medicine.button_lv_max",function()
            local free_points = inst.components.chemist_com_skill_point_sys:GetFreePoints()
            if free_points <= 0 then
                return
            end
            local current_level = inst.components.chemist_com_skill_point_sys:Add("attack_power_multiplier_medicine.item_level",0)
            local max = 5

            local cost_point = 0

            local need_point = max - current_level
            if free_points >= need_point then
                cost_point = need_point
            else
                cost_point = free_points
            end

            if cost_point <= 0 or current_level >= max then
                return
            end

            inst.components.chemist_com_skill_point_sys:FreePointDelta(-1 * cost_point)

            local ret = inst.components.chemist_com_skill_point_sys:Add("attack_power_multiplier_medicine.item_level",cost_point)
            if ret > max then
                inst.components.chemist_com_skill_point_sys:Set("attack_power_multiplier_medicine.item_level",max)
            end
        end)
    --------------------------------------------------------------------------
    ----- 双倍
        inst.components.chemist_com_skill_point_sys:AddButtonFn("attack_power_multiplier_medicine.button_double_lv_up",function()
            local free_points = inst.components.chemist_com_skill_point_sys:GetFreePoints()
            if free_points <= 0 then
                return
            end
            local max = 5

            local current_level = inst.components.chemist_com_skill_point_sys:Add("attack_power_multiplier_medicine.double_level",0)
            if current_level >= max then
                return
            end

            current_level = current_level + 1

            if current_level >= max  then
                current_level = max
            end

            inst.components.chemist_com_skill_point_sys:FreePointDelta(-1)
            inst.components.chemist_com_skill_point_sys:Set("attack_power_multiplier_medicine.double_level",current_level)

        end)
        inst.components.chemist_com_skill_point_sys:AddButtonFn("attack_power_multiplier_medicine.button_double_lv_max",function()
            local free_points = inst.components.chemist_com_skill_point_sys:GetFreePoints()
            if free_points <= 0 then
                return
            end
            local current_level = inst.components.chemist_com_skill_point_sys:Add("attack_power_multiplier_medicine.double_level",0)
            local max = 5

            local cost_point = 0

            local need_point = max - current_level
            if free_points >= need_point then
                cost_point = need_point
            else
                cost_point = free_points
            end

            if cost_point <= 0 or current_level >= max then
                return
            end

            inst.components.chemist_com_skill_point_sys:FreePointDelta(-1 * cost_point)

            local ret = inst.components.chemist_com_skill_point_sys:Add("attack_power_multiplier_medicine.double_level",cost_point)
            if ret > max then
                inst.components.chemist_com_skill_point_sys:Set("attack_power_multiplier_medicine.double_level",max)
            end

        end)
    

end