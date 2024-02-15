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
            ["chemist_item_exp_medicine"] = {
                ["name"] = "经验药剂 Lv1",
                ["inspect_str"] = "独属于药剂师的药剂",
                ["recipe_desc"] = "独属于药剂师的药剂",
            },
            ["chemist_item_exp_medicine2"] = {
                ["name"] = "经验药剂 Lv2",
                ["inspect_str"] = "独属于药剂师的药剂",
                ["recipe_desc"] = "独属于药剂师的药剂",
            },
            ["chemist_item_exp_medicine3"] = {
                ["name"] = "经验药剂 Lv3",
                ["inspect_str"] = "独属于药剂师的药剂",
                ["recipe_desc"] = "独属于药剂师的药剂",
            },

            ["chemist_item_attack_power_multiplier_medicine_lv_1"] = {
                ["name"] = "一级·攻击药剂",
                ["inspect_str"] = "一级·攻击药剂",
            },
            ["chemist_item_attack_power_multiplier_medicine_lv_2"] = {
                ["name"] = "二级·攻击药剂",
                ["inspect_str"] = "二级·攻击药剂",
            },
            ["chemist_item_attack_power_multiplier_medicine_lv_3"] = {
                ["name"] = "三级·攻击药剂",
                ["inspect_str"] = "三级·攻击药剂",
            },
            ["chemist_item_attack_power_multiplier_medicine_lv_4"] = {
                ["name"] = "四级·攻击药剂",
                ["inspect_str"] = "四级·攻击药剂",
            },
            ["chemist_item_attack_power_multiplier_medicine_lv_5"] = {
                ["name"] = "五级·攻击药剂",
                ["inspect_str"] = "五级·攻击药剂",
            },
            ["chemist_item_triple_recovery_medicine_lv_1"] = {
                ["name"] = "一级·三维恢复药剂",
                ["inspect_str"] = "一级·三维恢复药剂",
            },
            ["chemist_item_triple_recovery_medicine_lv_2"] = {
                ["name"] = "二级·三维恢复药剂",
                ["inspect_str"] = "二级·三维恢复药剂",
            },
            ["chemist_item_triple_recovery_medicine_lv_3"] = {
                ["name"] = "三级·三维恢复药剂",
                ["inspect_str"] = "三级·三维恢复药剂",
            },
            ["chemist_item_triple_recovery_medicine_lv_4"] = {
                ["name"] = "四级·三维恢复药剂",
                ["inspect_str"] = "四级·三维恢复药剂",
            },
            ["chemist_item_triple_recovery_medicine_lv_5"] = {
                ["name"] = "五级·三维恢复药剂",
                ["inspect_str"] = "五级·三维恢复药剂",
            },
            ["chemist_item_skill_points_reset_medicine"] = {
                ["name"] = "技能点重置药剂",
                ["inspect_str"] = "重置技能点",
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
            ["chemist_building_mushroom_house"] = {
                ["name"] = "神奇的蘑菇屋",
                ["inspect_str"] = "能培育蘑菇的小房子",
                ["recipe_desc"] = "能培育蘑菇的小房子",
            },
            ["chemist_building_moonshine_converter"] = {
                ["name"] = "月光转换器",
                ["inspect_str"] = "可以让月亮蘑菇和月亮碎片相互转换的神奇机器",
                ["inspect_str_burnt"] = "烧毁了不能用了",
                ["recipe_desc"] = "让月亮蘑菇和月亮碎片相互转换",
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
            ["chemist_spell_skill_book_open"] = {
                ["name"] = "打开技能书",
                ["inspect_str"] = "打开技能书",
                ["recipe_desc"] = "打开技能书",
            },
            ["chemist_spell_attack_power_multiplier_medicine_maker"] = {
                ["name"] = "攻击药剂",
                ["inspect_str"] = "攻击药剂",
                ["recipe_desc"] = "攻击药剂",
                ["fail_talks"] = {"又失败了","哎呀，失败了","手抖了"},
                ["double_talks"] = {"又多做了一些","越来越熟练了","心细就能多做一些"},
            },
            ["chemist_spell_attack_power_multiplier_medicine_maker2"] = {
                ["name"] = "攻击药剂",
                ["recipe_desc"] = "攻击药剂",
            },
            ["chemist_spell_triple_recovery_medicine_maker"] = {
                ["name"] = "三维恢复药剂",
                ["inspect_str"] = "三维恢复药剂",
                ["recipe_desc"] = "三维恢复药剂",
                ["fail_talks"] = {"又失败了","哎呀，失败了","手抖了"},
                ["double_talks"] = {"又多做了一些","越来越熟练了","心细就能多做一些"},
            },
            ["chemist_spell_triple_recovery_medicine_maker2"] = {
                ["name"] = "三维恢复药剂",
                ["recipe_desc"] = "三维恢复药剂",
            },
        --------------------------------------------------------------------
        --- 10_plant_and_seeds
            ["firenettles_seeds"] = {
                ["name"] = "火荨麻种子",
                ["inspect_str"] = "火荨麻种子",
                ["recipe_desc"] = "火荨麻种子",
            },
            ["chemist_plant_wisdom_apple_tree"] = {
                ["name"] = "智慧树",
                ["inspect_str"] = "智慧树上智慧果，智慧树下你和我",
            },
            ["chemist_plant_wisdom_apple_tree_item"] = {
                ["name"] = "智慧树苗",
                ["inspect_str"] = "智慧树苗",
            },
        --------------------------------------------------------------------
}

