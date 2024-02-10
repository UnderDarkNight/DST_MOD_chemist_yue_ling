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
        --- 02_items
            ["chemist_item_firenettles_medicine_bottle"] = {
                ["name"] = "火荨麻药剂",
                ["inspect_str"] = "弹药",
                ["recipe_desc"] = "弹药",
            },
            ["chemist_item_empty_bottle"] = {
                ["name"] = "空药剂瓶",
                ["inspect_str"] = "空药剂瓶",
                ["recipe_desc"] = "空药剂瓶",
            },
            ["chemist_item_herbal_bag"] = {
                ["name"] = "药材袋",
                ["inspect_str"] = "能放些吃的和药材",
                ["recipe_desc"] = "能放些吃的和药材",
            },
            ["chemist_item_pill_box"] = {
                ["name"] = "药剂匣",
                ["inspect_str"] = "只能放置药剂",
                ["recipe_desc"] = "只能放置药剂",
            },
        --------------------------------------------------------------------
        --- 03_equipments
            ["chemist_equipment_chemical_launching_gun"] = {
                ["name"] = "药剂发射器",
                ["inspect_str"] = "用来发射药剂",
                ["recipe_desc"] = "用来发射药剂",
            },
            ["chemist_equipment_sublime_backpack"] = {
                ["name"] = "次元背包",
                ["inspect_str"] = "能返鲜的容器",
                ["recipe_desc"] = "能返鲜的容器",
            },
        --------------------------------------------------------------------
}

