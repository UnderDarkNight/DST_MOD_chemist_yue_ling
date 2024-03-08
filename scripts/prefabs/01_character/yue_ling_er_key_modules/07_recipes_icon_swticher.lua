--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

制作栏图标切换

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    inst:DoTaskInTime(1,function()
        

        if not (ThePlayer and inst == ThePlayer ) then
            return
        end



        local recipe_icon_fns = {

            ----------------------------------------------------------------------------------------------
                ["chemist_spell_attack_power_multiplier_medicine_maker"] = function(prefab_name)
                                --- 攻击药水 chemist_spell_attack_power_multiplier_medicine_maker
                            --- chemist_item_attack_power_multiplier_medicine_lv_1
                            local level = ThePlayer.replica.chemist_com_skill_point_sys:Get("attack_power_multiplier_medicine.item_level") or 0
                            if level < 1 then
                                level = 1
                            end
                            if level > 5 then
                                level = 5                                
                            end
                            local file_name = "chemist_item_attack_power_multiplier_medicine_lv_"..tostring(level)..".tex"
                            AllRecipes[prefab_name].atlas = GetInventoryItemAtlas(file_name)
                            AllRecipes[prefab_name].image = file_name

                            ---- 另外一个maker
                            prefab_name = prefab_name .. "2"
                            AllRecipes[prefab_name].atlas = GetInventoryItemAtlas(file_name)
                            AllRecipes[prefab_name].image = file_name
                end,
            ----------------------------------------------------------------------------------------------
                ["chemist_spell_triple_recovery_medicine_maker"] = function(prefab_name)
                            local level = ThePlayer.replica.chemist_com_skill_point_sys:Get("triple_recovery_medicine.item_level") or 0
                            if level < 1 then
                                level = 1
                            end
                            if level > 5 then
                                level = 5                                
                            end
                            
                            local file_name = "chemist_item_triple_recovery_medicine_lv_"..tostring(level)..".tex"
                            AllRecipes[prefab_name].atlas = GetInventoryItemAtlas(file_name)
                            AllRecipes[prefab_name].image = file_name

                            ---- 另外一个maker
                            prefab_name = prefab_name .. "2"
                            AllRecipes[prefab_name].atlas = GetInventoryItemAtlas(file_name)
                            AllRecipes[prefab_name].image = file_name
                end,
            ----------------------------------------------------------------------------------------------
                ["chemist_spell_revival_medicine_maker"] = function(prefab_name)
                            local level = ThePlayer.replica.chemist_com_skill_point_sys:Get("revival_medicine.item_level") or 0
                            if level < 1 then
                                level = 1
                            end
                            if level > 5 then
                                level = 5                                
                            end
                            
                            local file_name = "chemist_item_revival_medicine_lv_"..tostring(level)..".tex"
                            AllRecipes[prefab_name].atlas = GetInventoryItemAtlas(file_name)
                            AllRecipes[prefab_name].image = file_name

                            ---- 另外一个maker
                            prefab_name = prefab_name .. "2"
                            AllRecipes[prefab_name].atlas = GetInventoryItemAtlas(file_name)
                            AllRecipes[prefab_name].image = file_name
                end,
            ----------------------------------------------------------------------------------------------
        }



        local recipe_icon_update_fn = function()
            pcall(function()                
                for temp_prefab, temp_fn in pairs(recipe_icon_fns) do
                    if temp_prefab and temp_fn then
                        temp_fn(temp_prefab)
                    end
                end
                ThePlayer:PushEvent("refreshcrafting")
            end)
        end

        recipe_icon_update_fn()
        ThePlayer.replica.chemist_com_skill_point_sys:AddDataUpdateFn(recipe_icon_update_fn)




    end)

end