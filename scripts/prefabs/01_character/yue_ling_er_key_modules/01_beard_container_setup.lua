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

        local beard_container_open_fn = function()
            local beard_container = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BEARD)
            if beard_container then
                beard_container.components.container:Open(inst)
            end
        end
        inst:ListenForEvent("unequip",beard_container_open_fn)
        inst:ListenForEvent("equip",beard_container_open_fn)


        ------------------------------------------------------------------------------------------
        --- 玩家重选的时候删除
            inst:ListenForEvent("ms_playerreroll",function()
                local beard_container = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BEARD)
                beard_container.components.container:DropEverything()
                beard_container:Remove()
            end)
        ------------------------------------------------------------------------------------------
    end)
end