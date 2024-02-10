if TUNING["chemist_yue_ling.Strings"] == nil then
    TUNING["chemist_yue_ling.Strings"] = {}
end

local this_language = "en"
if TUNING["chemist_yue_ling.Language"] then
    if type(TUNING["chemist_yue_ling.Language"]) == "function" and TUNING["chemist_yue_ling.Language"]() ~= this_language then
        return
    elseif type(TUNING["chemist_yue_ling.Language"]) == "string" and TUNING["chemist_yue_ling.Language"] ~= this_language then
        return
    end
end

TUNING["chemist_yue_ling.Strings"][this_language] = TUNING["chemist_yue_ling.Strings"][this_language] or {
        --------------------------------------------------------------------
        --- 正在debug 测试的
            -- ["chemist_yue_ling_skin_test_item"] = {
            --     ["name"] = "en皮肤测试物品",
            --     ["inspect_str"] = "en inspect单纯的测试皮肤",
            --     ["recipe_desc"] = " en 测试描述666",
            -- },        
        --------------------------------------------------------------------

}