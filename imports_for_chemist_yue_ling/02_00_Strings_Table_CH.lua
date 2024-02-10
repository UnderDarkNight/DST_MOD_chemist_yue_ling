if TUNING["chemist_yue_ling.Strings"] == nil then
    TUNING["chemist_yue_ling.Strings"] = {}
end

local this_language = "ch"
-- if TUNING["chemist_yue_ling.Language"] then
--     if type(TUNING["chemist_yue_ling.Language"]) == "function" and TUNING["chemist_yue_ling.Language"]() ~= this_language then
--         return
--     elseif type(TUNING["chemist_yue_ling.Language"]) == "string" and TUNING["chemist_yue_ling.Language"] ~= this_language then
--         return
--     end
-- end

--------- 默认加载中文文本，如果其他语言的文本缺失，直接调取 中文文本。 03_TUNING_Common_Func.lua
--------------------------------------------------------------------------------------------------
--- 默认显示名字:  name
--- 默认显示描述:  inspect_str
--- 默认制作栏描述: recipe_desc
--------------------------------------------------------------------------------------------------
TUNING["chemist_yue_ling.Strings"][this_language] = TUNING["chemist_yue_ling.Strings"][this_language] or {
        --------------------------------------------------------------------
        --- 正在debug 测试的
            ["chemist_yue_ling_skin_test_item"] = {
                ["name"] = "皮肤测试物品",
                ["inspect_str"] = "inspect单纯的测试皮肤",
                ["recipe_desc"] = "测试描述666",
            },
        --------------------------------------------------------------------
        --- 组件动作
           
        --------------------------------------------------------------------
}

