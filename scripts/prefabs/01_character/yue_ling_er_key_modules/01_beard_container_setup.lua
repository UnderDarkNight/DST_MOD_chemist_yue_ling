--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[



]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end
    inst:DoTaskInTime(0,function()
        local flag = inst.components.chemist_com_database:Get("beard_container_setup")
        if not flag then
            inst.components.chemist_com_database:Set("beard_container_setup",true)
            inst.components.inventory:Equip(SpawnPrefab("chemist_other_beard_container"))
        end
    end)
end