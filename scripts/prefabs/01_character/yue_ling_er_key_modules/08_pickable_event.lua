--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    采集事件

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end


    inst:ListenForEvent("picksomething",function(_,_table)
        if not (_table and _table.object) then
            return
        end
        local target = _table.object
        -- print("picksomething",target)

        local target_fns = {
            ["weed_firenettle"] = function()
                inst.components.inventory:GiveItem(SpawnPrefab("firenettles_seeds"))
            end,
        }

        if target_fns[target.prefab] then
            target_fns[target.prefab]()
        end

        inst.components.sanity:DoDelta(1)

    end)

end