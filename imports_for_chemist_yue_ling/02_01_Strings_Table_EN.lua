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
           
        --------------------------------------------------------------------
        --- 02_items
            ["chemist_item_firenettles_medicine_bottle"] = {
                ["name"] = "Firenettles Medicine Bottle",
                ["inspect_str"] = "munitions",
                ["recipe_desc"] = "munitions",
            },
            ["chemist_item_empty_bottle"] = {
                ["name"] = "Empty Bottle",
                ["inspect_str"] = "Empty Bottle",
                ["recipe_desc"] = "Empty Bottle",
            },
            ["chemist_item_herbal_bag"] = {
                ["name"] = "Herbal Bag",
                ["inspect_str"] = "You can put some food and herbs in there.",
                ["recipe_desc"] = "You can put some food and herbs in there.",
            },
            ["chemist_item_pill_box"] = {
                ["name"] = "Medicine Box",
                ["inspect_str"] = "Only medicine bottle can be placed.",
                ["recipe_desc"] = "Only medicine bottle can be placed.",
            },
            ["chemist_item_restorative_medicine_bottle"] = {
                ["name"] = "Restorative Medicine Bottle",
                ["inspect_str"] = "Restorative Medicine Bottle",
                ["recipe_desc"] = "Restorative Medicine Bottle",
            },
            ["chemist_item_cola_soda"] = {
                ["name"] = "Geek Love (Coke)",
                ["inspect_str"] = "Running faster for a while",
                ["recipe_desc"] = "Running faster for a while",
            },
            ["chemist_item_plant_growth_medicine"] = {
                ["name"] = "Plant Growth Medicine",
                ["inspect_str"] = "Let the plants flourish.",
                ["recipe_desc"] = "Let the plants flourish.",
            },
            ["chemist_item_wisdom_medicine"] = {
                ["name"] = "wisdom Medicine",
                ["inspect_str"] = "Drinking this ink will make you smarter.",
                ["recipe_desc"] = "Drinking this ink will make you smarter.",
            },
            ["chemist_item_jinkela_medicine"] = {
                ["name"] = "Jinkela Medicine",
                ["inspect_str"] = "Use on plants",
                ["recipe_desc"] = "Use on plants",
            },
            ["chemist_item_exp_medicine"] = {
                ["name"] = "Exp Medicine",
                ["inspect_str"] = "A medicine that belongs exclusively to the chemist.",
                ["recipe_desc"] = "A medicine that belongs exclusively to the chemist.",
            },

            ["chemist_item_attack_power_multiplier_medicine_lv_1"] = {
                ["name"] = "Lv1 Damage Multiplier Medicine",
                ["inspect_str"] = "Lv1 Damage Multiplier Medicine",
            },
            ["chemist_item_attack_power_multiplier_medicine_lv_2"] = {
                ["name"] = "Lv2 Damage Multiplier Medicine",
                ["inspect_str"] = "Lv2 Damage Multiplier Medicine",
            },
            ["chemist_item_attack_power_multiplier_medicine_lv_3"] = {
                ["name"] = "Lv3 Damage Multiplier Medicine",
                ["inspect_str"] = "Lv3 Damage Multiplier Medicine",
            },
            ["chemist_item_attack_power_multiplier_medicine_lv_4"] = {
                ["name"] = "Lv4 Damage Multiplier Medicine",
                ["inspect_str"] = "Lv4 Damage Multiplier Medicine",
            },
            ["chemist_item_attack_power_multiplier_medicine_lv_5"] = {
                ["name"] = "Lv5 Damage Multiplier Medicine",
                ["inspect_str"] = "Lv5 Damage Multiplier Medicine",
            },
            ["chemist_item_triple_recovery_medicine_lv_1"] = {
                ["name"] = "Lv1 Tiple Recovery Medicine",
                ["inspect_str"] = "Lv1 Tiple Recovery Medicine",
            },
            ["chemist_item_triple_recovery_medicine_lv_2"] = {
                ["name"] = "Lv2 Tiple Recovery Medicine",
                ["inspect_str"] = "Lv2 Tiple Recovery Medicine",
            },
            ["chemist_item_triple_recovery_medicine_lv_3"] = {
                ["name"] = "Lv3 Tiple Recovery Medicine",
                ["inspect_str"] = "Lv3 Tiple Recovery Medicine",
            },
            ["chemist_item_triple_recovery_medicine_lv_4"] = {
                ["name"] = "Lv4 Tiple Recovery Medicine",
                ["inspect_str"] = "Lv4 Tiple Recovery Medicine",
            },
            ["chemist_item_triple_recovery_medicine_lv_5"] = {
                ["name"] = "Lv5 Tiple Recovery Medicine",
                ["inspect_str"] = "Lv5 Tiple Recovery Medicine",
            },
            ["chemist_item_skill_points_reset_medicine"] = {
                ["name"] = "Skill Points Reset Medicine",
                ["inspect_str"] = "Skill Points Reset Medicine",
            },
        --------------------------------------------------------------------
        --- 03_equipments
            ["chemist_equipment_chemical_launching_gun"] = {
                ["name"] = "Medicine Launching Gun",
                ["inspect_str"] = "Used to launch medicine bottles",
                ["recipe_desc"] = "Used to launch medicine bottles",
            },
            ["chemist_equipment_sublime_backpack"] = {
                ["name"] = "Sublime Backpack",
                ["inspect_str"] = "Backpacks that keep food fresh",
                ["recipe_desc"] = "Backpacks that keep food fresh",
            },
        --------------------------------------------------------------------
        --- 06_buildings
            ["chemist_building_pharmaceutical_manufacturing_station"] = {
                ["name"] = "pharmaceutical Manufacturing Station",
                ["inspect_str"] = "pharmaceutical Manufacturing Station",
                ["inspect_str_burnt"] = "It's burned out. It doesn't work.",
                ["recipe_desc"] = "pharmaceutical Manufacturing Station",
            },
            ["chemist_building_mushroom_house"] = {
                ["name"] = "Mushroom House",
                ["inspect_str"] = "Little house that grows mushrooms",
                ["recipe_desc"] = "Little house that grows mushrooms",
            },
            ["chemist_building_moonshine_converter"] = {
                ["name"] = "Moonshine Converter",
                ["inspect_str"] = "A magical machine that allows moon mushrooms and moon grass to transform into each other.",
                ["inspect_str_burnt"] = "It's burned out. It doesn't work.",
                ["recipe_desc"] = "Interchange the Moon Mushroom and Moon Grass",
            },
        --------------------------------------------------------------------
        --- 07_foods        
            ["chemist_food_wisdom_apple"] = {
                ["name"] = "Wisdom Apple",
                ["inspect_str"] = "Fruit of Wisdom on the Tree of Wisdom, You and I under the Tree of Wisdom",
                ["recipe_desc"] = "Fruit of Wisdom on the Tree of Wisdom, You and I under the Tree of Wisdom",
            },
        --------------------------------------------------------------------
        --- 09_spells
            ["chemist_spell_empty_bottle_maker"] = {
                ["name"] = "Empty Bottle",
                ["inspect_str"] = "Empty Bottle",
                ["recipe_desc"] = "Empty Bottle",
            },
            ["chemist_spell_skill_book_open"] = {
                ["name"] = "Open the skill book",
                ["inspect_str"] = "Open the skill book",
                ["recipe_desc"] = "Open the skill book",
            },
            ["chemist_spell_attack_power_multiplier_medicine_maker"] = {
                ["name"] = "Damage Multiplier Medicine",
                ["inspect_str"] = "Damage Multiplier Medicine",
                ["recipe_desc"] = "Damage Multiplier Medicine",
                ["fail_talks"] = {"Failed again.","Oops, failed.","Hands are shaking."},
                ["double_talks"] = {"Made some more.","Getting better at it.","If I'm careful, I can do more."},

            },
            ["chemist_spell_attack_power_multiplier_medicine_maker2"] = {
                ["name"] = "Damage Multiplier Medicine",
                ["recipe_desc"] = "Damage Multiplier Medicine",
            },
            ["chemist_spell_triple_recovery_medicine_maker"] = {
                ["name"] = "Triple Recovery Medicine",
                ["inspect_str"] = "Triple Recovery Medicine",
                ["recipe_desc"] = "Triple Recovery Medicine",
                ["fail_talks"] = {"Failed again.","Oops, failed.","Hands are shaking."},
                ["double_talks"] = {"Made some more.","Getting better at it.","If I'm careful, I can do more."},
            },
            ["chemist_spell_triple_recovery_medicine_maker2"] = {
                ["name"] = "Triple Recovery Medicine",
                ["recipe_desc"] = "Triple Recovery Medicine",
            },
        --------------------------------------------------------------------
        --- 10_plant_and_seeds
            ["firenettles_seeds"] = {
                ["name"] = "Firenettles Seeds",
                ["inspect_str"] = "Firenettles Seeds",
                ["recipe_desc"] = "Firenettles Seeds",
            },
            ["chemist_plant_wisdom_apple_tree"] = {
                ["name"] = "Wisdom Apple Tree",
                ["inspect_str"] = "Fruit of Wisdom on the Tree of Wisdom, You and I under the Tree of Wisdom",
            },
            ["chemist_plant_wisdom_apple_tree_item"] = {
                ["name"] = "Wisdom Apple Sapling",
                ["inspect_str"] = "Wisdom Apple Sapling",
            },
        --------------------------------------------------------------------

}