--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    植物人的tag ： plantkin

    仙人掌采集不掉血 ： picker.components.inventory:EquipHasTag("bramble_resistant")

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)

    inst:AddTag("plantkin")      --- 直接可以种植作物

    if not TheWorld.ismastersim then
        return
    end

end