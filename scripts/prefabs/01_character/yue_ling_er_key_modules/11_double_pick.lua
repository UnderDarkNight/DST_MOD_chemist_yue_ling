--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    150 级的时候采集双倍

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end


    inst:ListenForEvent("picksomething",function(_,_table)
        if not (_table and type(_table.loot) == "table" ) then
            return
        end

        -- print("+++++++++picksomething++++++")
        -- for k, v in pairs(_table.loot) do
        --     print(k,v)
        -- end
        -- print("+++++++++picksomething++++++")

        if inst.components.chemist_com_level_sys:Get_Level() >= (TUNING.CHEMIST_YUE_LING_DEBUGGING_MODE and 10 or 150) then


                        if _table.loot.prefab then  ---- 单个物品

                                local item = _table.loot
                                if item.components.stackable then
                                    item.components.stackable.stacksize = item.components.stackable.stacksize * 2
                                else
                                    inst.components.inventory:GiveItem(SpawnPrefab(item.prefab))
                                end

                        else
                                for k, temp_item in pairs(_table.loot) do
                                    if type(temp_item) == "table" and temp_item.prefab then
                                        if temp_item.components.stackable then
                                            temp_item.components.stackable.stacksize = temp_item.components.stackable.stacksize * 2
                                        else
                                            inst.components.inventory:GiveItem(SpawnPrefab(temp_item.prefab))
                                        end
                                    end
                                end

                        end

        end

    end)

end