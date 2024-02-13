local assets =
{
    -- Asset("ANIM", "anim/fireflies.zip"),
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    local function GetStringsTable(name)
        local prefab_name = name or "chemist_spell_attack_power_multiplier_medicine_maker"
        local LANGUAGE = type(TUNING["chemist_yue_ling.Language"]) == "function" and TUNING["chemist_yue_ling.Language"]() or TUNING["chemist_yue_ling.Language"]
        return TUNING["chemist_yue_ling.Strings"][LANGUAGE][prefab_name] or {}
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function builder_onbuilt(inst, builder)
    -- print(inst,builder,"fake error")
	if builder and builder:HasTag("chemist_yue_ling") then


        -- builder:PushEvent("chemist_empty_bottle_maked",item)
        local item_level = builder.components.chemist_com_skill_point_sys:Add("attack_power_multiplier_medicine.item_level",0)
        local double_level = builder.components.chemist_com_skill_point_sys:Add("attack_power_multiplier_medicine.double_level",0)



        -- local item = SpawnPrefab("chemist_item_empty_bottle")
        
        -- builder.components.inventory:GiveItem(item)
        local x,y,z = builder.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 3, {"chemist_building_pharmaceutical_manufacturing_station"}, {"burnt"}, nil) or {}
        local station = ents[1]

        local succeed_rate = 0.1
        if item_level > 0 then
            succeed_rate = 1
        end
        if station then
            succeed_rate = 1
        end

        if math.random(1000)/1000 <= succeed_rate then
            ---- 制作成功
                if item_level == 0 then
                    item_level = 1
                end
                if item_level > 5 then
                    item_level = 5
                end

                local item = SpawnPrefab("chemist_item_attack_power_multiplier_medicine_lv_"..tostring(item_level))

                local double_rate = 0.2*double_level
                if math.random(1000)/1000 <= double_rate then
                    item.components.stackable.stacksize = 2
                    if builder.components.talker and math.random(100) < 50 then
                        local double_strings = GetStringsTable()["double_talks"] or {}
                        local double_sting = double_strings[math.random(#double_strings)] or "又多做了一份"
                        builder.components.talker:Say(double_sting)
                    end
                end

                if station and item_level > 0 then
                    item.components.stackable.stacksize = item.components.stackable.stacksize + 1
                end

                builder.components.inventory:GiveItem(item)

                if station then
                    station:PushEvent("__builditem")
                end

        else
            ---- 制作失败
            SpawnPrefab("chemist_fx_explode"):PushEvent("Set",{
                target = builder,
                color = Vector3(1,0,0),
                MultColour_Flag = true
            })
            if builder.components.talker then
                local fail_strings = GetStringsTable()["fail_talks"] or {}
                local fail_string = fail_strings[math.random(#fail_strings)] or "又失败了"
                builder.components.talker:Say(fail_string)
            end

        end
    end
    inst:Remove()
end

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst:AddTag("CLASSIFIED")

    inst.persists = false

    inst:DoTaskInTime(0, inst.Remove)

    


    if not TheWorld.ismastersim then
        return inst
    end

    inst.OnBuiltFn = builder_onbuilt

   
    return inst
end

return Prefab("chemist_spell_attack_power_multiplier_medicine_maker", fn,assets),
            Prefab("chemist_spell_attack_power_multiplier_medicine_maker2", fn,assets)