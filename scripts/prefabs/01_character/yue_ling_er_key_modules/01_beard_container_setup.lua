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
                if beard_container.components.container and beard_container.replica.container then
                    beard_container.components.container:Open(inst)
                else
                    ----- 不知道为什么 会丢失 replica container 崩溃，强制重新给一个
                    beard_container:Remove()
                    inst.components.inventory:Equip(SpawnPrefab("chemist_other_beard_container"))
                end
            else
                inst.components.inventory:Equip(SpawnPrefab("chemist_other_beard_container"))
            end
        end
        inst:ListenForEvent("unequip",beard_container_open_fn)
        inst:ListenForEvent("equip",beard_container_open_fn)


    end)
end