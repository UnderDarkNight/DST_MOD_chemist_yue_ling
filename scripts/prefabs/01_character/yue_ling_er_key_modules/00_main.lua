--------------------------------------------------------------------------------------------------------------------------------------------------
---- 模块总入口，使用 common_postinit 进行嵌入初始化，注意 mastersim 区分
--------------------------------------------------------------------------------------------------------------------------------------------------
return function(inst)

    if TheWorld.ismastersim then
        if inst.components.chemist_com_database == nil then
            inst:AddComponent("chemist_com_database") --- 通用用数据库
        end
        
        inst:AddComponent("chemist_com_rpc_event") --- RPC 信道封装
    end

    local modules = {
        "prefabs/01_character/yue_ling_er_key_modules/01_beard_container_setup",                    ---- 安装胡子容器

    }
    for k, lua_addr in pairs(modules) do
        local temp_fn = require(lua_addr)
        if type(temp_fn) == "function" then
            temp_fn(inst)
        end
    end


    -- inst:AddTag("playermonster")   --- 会被中立怪物攻击
    -- inst:AddTag("monster")
    inst:AddTag("chemist_yue_ling")

    inst:AddTag("farmplantfastpicker")  --- 种植作物快速采集
    inst:AddTag("fastpicker")  --- 可采集目标快速采集


    -- inst.customidleanim = "idle_wendy" --- 闲置站立动画
    -- inst:AddTag("stronggrip")      --- 不被打掉武器

    if not TheWorld.ismastersim then
        return
    end


    -- if TUNING.UNDERWORLD_HANA_DEBUGGING_MODE then
    -- end

    inst:AddComponent("reader")     --- 读书

end