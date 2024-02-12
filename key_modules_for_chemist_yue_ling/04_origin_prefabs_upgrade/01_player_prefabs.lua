




AddPlayerPostInit(function(inst)




    if not TheWorld.ismastersim then
        return
    end

    if inst.components.chemist_com_database == nil then
        inst:AddComponent("chemist_com_database") --- 通用数据库
    end

end)