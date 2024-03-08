--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[


药剂发射器，火荨麻药剂20个，可乐5个，次元背包


]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end

    inst:DoTaskInTime(0,function()

        if inst.components.chemist_com_database:Get("new_spawn_gift") then
            return
        end
        inst.components.chemist_com_database:Set("new_spawn_gift",true) 

        -----------------  背包
            local backpack = SpawnPrefab("chemist_equipment_sublime_backpack")
            inst.components.inventory:GiveItem(backpack)
            -- backpack.Transform:SetPosition(inst.Transform:GetWorldPosition())

        -----------------  手枪
            local gun = SpawnPrefab("chemist_equipment_chemical_launching_gun")
            inst.components.inventory:GiveItem(gun)

        -----------------  火荨麻药剂
            local firenettles_medicine_bottle = SpawnPrefab("chemist_item_firenettles_medicine_bottle")
            firenettles_medicine_bottle.components.stackable.stacksize = 20
            inst.components.inventory:GiveItem(firenettles_medicine_bottle)


        -----------------  可乐
            local cola_soda = SpawnPrefab("chemist_item_cola_soda")
            cola_soda.components.stackable.stacksize = 5
            inst.components.inventory:GiveItem(cola_soda)




    end)
end