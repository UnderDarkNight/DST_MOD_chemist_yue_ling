--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[



]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end



    -- inst:ListenForEvent("entity_death", function(src, data) 
    --     data = data or {}
    --     local death_monster = data.inst
    --     if death_monster and not death_monster:HasTag("chemist_com_level_sys.max_flag") then

    --         if inst.components.chemist_com_level_sys:IsMaxLevel() then
    --             death_monster:AddTag("chemist_com_level_sys.max_flag")

    --             if death_monster.components.lootdropper then
    --                 death_monster.components.lootdropper:DropLoot()
    --                 print("info 双倍掉落",death_monster)
    --             end

    --         end

    --     end

    -- end, TheWorld)

    inst:ListenForEvent("killed",function(_,_talbe)
        if not(_talbe and _talbe.victim) then
            return
        end

        local death_monster = _talbe.victim
        if death_monster and not death_monster:HasTag("chemist_com_level_sys.max_flag") then

            if inst.components.chemist_com_level_sys:IsMaxLevel() then
                death_monster:AddTag("chemist_com_level_sys.max_flag")

                if death_monster.components.lootdropper then
                    death_monster.components.lootdropper:DropLoot()
                    -- print("info 双倍掉落",death_monster)
                end

            end

        end

    end)

end