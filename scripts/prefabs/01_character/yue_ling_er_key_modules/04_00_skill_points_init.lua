--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    技能册保存

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end


    --------------------------------------------------------------------------------
    ---- 换角色的时候保存玩家技能点
        if not TheWorld:HasTag("cave") then

            inst:ListenForEvent("ms_playerreroll",function()    --- 通过绚丽之门选角色的时候触发
                local data = inst.components.chemist_com_skill_point_sys:OnSave()
                local index = "chemist_com_skill_point_sys."..tostring(inst.userid)
                TheWorld.components.chemist_com_database:Set(index,data)
            end)
            inst:DoTaskInTime(0,function()
                local index = "chemist_com_skill_point_sys."..tostring(inst.userid)
                local data = TheWorld.components.chemist_com_database:Get(index)
                if data then
                    inst.components.chemist_com_skill_point_sys:OnLoad(data)
                    inst.components.chemist_com_skill_point_sys:Data_Synchronization()
                end
                TheWorld.components.chemist_com_database:Set(index,nil)
            end)
        end
    --------------------------------------------------------------------------------

end