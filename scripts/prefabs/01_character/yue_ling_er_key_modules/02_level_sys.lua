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
    --------------------------------------------------------------------------------
        inst:AddComponent("chemist_com_level_sys")

    --------------------------------------------------------------------------------
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
    --------------------------------------------------------------------------------
        inst.components.chemist_com_level_sys.max_level = 200
        inst.components.chemist_com_level_sys:Add_Level_Changed_Fn(level_refresh)
        inst.components.chemist_com_level_sys:SetOnLoadFn(level_refresh)


        for i = 1, 200, 1 do
            inst.components.chemist_com_level_sys:Add_Level_Event(i,function()
                -- print("info 等级到达：",i)
            end)
            if i%2 == 0 then
                inst.components.chemist_com_level_sys:Add_Level_Event(i,function()
                    inst.components.chemist_com_skill_point_sys:FreePointDelta(1)
                end)
            end
        end
    --------------------------------------------------------------------------------
    ----
    --------------------------------------------------------------------------------
    ---- 换角色的时候保存玩家等级.
        inst:ListenForEvent("ms_playerreroll",function()    --- 通过绚丽之门选角色的时候触发
            local current_level = inst.replica.chemist_com_level_sys:GetCurrentLevel()
            local current_exp = inst.replica.chemist_com_level_sys:GetCurrentExp()
            local data = {
                current_level = current_level,
                current_exp = current_exp,
            }
            local index = "chemist_com_level_sys."..tostring(inst.userid)
            TheWorld.components.chemist_com_database:Set(index,data)
        end)
        inst:DoTaskInTime(0,function()
            local index = "chemist_com_level_sys."..tostring(inst.userid)
            local data = TheWorld.components.chemist_com_database:Get(index)
            if data and inst.components.chemist_com_level_sys.current_level == 0 then
                inst.components.chemist_com_level_sys:LevelUp(data.current_level or 0)
                inst.components.chemist_com_level_sys:Add_Exp(data.current_exp or 0)
                print("fake error : 玩家等级重新更新到：",data.current_level,data.current_exp)

                inst.components.health:SetPercent(1)
                inst.components.hunger:SetPercent(1)
                inst.components.sanity:SetPercent(1)
            end
            TheWorld.components.chemist_com_database:Set(index,nil)
        end)
    --------------------------------------------------------------------------------

end