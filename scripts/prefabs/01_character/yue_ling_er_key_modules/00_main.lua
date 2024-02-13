--------------------------------------------------------------------------------------------------------------------------------------------------
---- 模块总入口，使用 common_postinit 进行嵌入初始化，注意 mastersim 区分
--------------------------------------------------------------------------------------------------------------------------------------------------
return function(inst)

    if TheWorld.ismastersim then
        if inst.components.chemist_com_database == nil then
            inst:AddComponent("chemist_com_database") --- 通用用数据库
        end
        
        inst:AddComponent("chemist_com_rpc_event") --- RPC 信道封装
        inst:AddComponent("chemist_com_skill_point_sys") --- 技能册系统
    end

    local modules = {
        "prefabs/01_character/yue_ling_er_key_modules/01_beard_container_setup",                    ---- 安装胡子容器
        "prefabs/01_character/yue_ling_er_key_modules/02_level_sys",                    ---- 等级系统
        "prefabs/01_character/yue_ling_er_key_modules/03_double_dropper",                    ---- 双倍掉落检查

        "prefabs/01_character/yue_ling_er_key_modules/04_01_skill_point_page_1",                    ---- 技能册 第 1 页 执行函数
        "prefabs/01_character/yue_ling_er_key_modules/04_02_skill_point_page_2",                    ---- 技能册 第 2 页 执行函数


        "prefabs/01_character/yue_ling_er_key_modules/05_empty_bottle_maker",                    ---- 制作空瓶，有概率 得多几个

        "prefabs/01_character/yue_ling_er_key_modules/06_animstate_hook",                    ---- 角色动画组件hook

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


    inst.customidleanim = "idle_wendy"  -- 闲置站立动画
    inst.soundsname = "wendy"           -- 角色声音

    -- inst:AddTag("stronggrip")      --- 不被打掉武器

    local scale = 1.2
    inst.AnimState:SetScale(scale, scale,scale)

    if not TheWorld.ismastersim then
        return
    end


    -- if TUNING.chemist_yue_ling_DEBUGGING_MODE then
    -- end

    inst:AddComponent("reader")     --- 读书

end