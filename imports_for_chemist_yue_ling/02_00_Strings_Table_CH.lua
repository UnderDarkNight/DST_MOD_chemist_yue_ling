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
            ["chemist_item_restorative_medicine_bottle"] = {
                ["name"] = "通用恢复药剂",
                ["inspect_str"] = "回复血量",
                ["recipe_desc"] = "回复血量",
            },
            ["chemist_item_cola_soda"] = {
                ["name"] = "宅男的爱（可乐）",
                ["inspect_str"] = "奔跑速度加快一段时间",
                ["recipe_desc"] = "奔跑速度加快一段时间",
            },
            ["chemist_item_plant_growth_medicine"] = {
                ["name"] = "植物生长药剂",
                ["inspect_str"] = "让植物长得旺盛些",
                ["recipe_desc"] = "让植物长得旺盛些",
            },
            ["chemist_item_wisdom_medicine"] = {
                ["name"] = "智慧药剂",
                ["inspect_str"] = "喝了这墨水会更聪明",
                ["recipe_desc"] = "喝了这墨水会更聪明",
            },
            ["chemist_item_jinkela_medicine"] = {
                ["name"] = "金坷垃药剂",
                ["inspect_str"] = "对植物使用",
                ["recipe_desc"] = "对植物使用",
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
        --- 06_buildings
            ["chemist_building_pharmaceutical_manufacturing_station"] = {
                ["name"] = "药剂制作站",
                ["inspect_str"] = "药剂制作站",
                ["inspect_str_burnt"] = "烧毁了不能用了",
                ["recipe_desc"] = "药剂制作站",
            },
        --------------------------------------------------------------------
        --- 07_foods        
            ["chemist_food_wisdom_apple"] = {
                ["name"] = "智慧果",
                ["inspect_str"] = "智慧树上智慧果，智慧树下你和我",
                ["recipe_desc"] = "智慧树上智慧果，智慧树下你和我",
            },
        --------------------------------------------------------------------
        --- 09_spells
            ["chemist_spell_empty_bottle_maker"] = {
                ["name"] = "空药剂瓶",
                ["inspect_str"] = "空药剂瓶",
                ["recipe_desc"] = "空药剂瓶",
            },
        --------------------------------------------------------------------
}

