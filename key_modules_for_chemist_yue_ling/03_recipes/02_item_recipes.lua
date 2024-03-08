







--------------------------------------------------------------------------------------------------------------------------------------------
---- 药剂发射器
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_equipment_chemical_launching_gun","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_equipment_chemical_launching_gun",            --  --  inst.prefab  实体名字
        { Ingredient("thulecite", 10) ,Ingredient("gears", 3),Ingredient("opalpreciousgem", 1) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_equipment_chemical_launching_gun.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_equipment_chemical_launching_gun.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_equipment_chemical_launching_gun","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 次元背包
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_equipment_sublime_backpack","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_equipment_sublime_backpack",            --  --  inst.prefab  实体名字
        { Ingredient("twigs", 10) ,Ingredient("rope", 5),Ingredient("goldnugget", 3) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_equipment_sublime_backpack.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_equipment_sublime_backpack.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_equipment_sublime_backpack","MODS")                       -- -- 在【模组物品】标签里移除这个。



--------------------------------------------------------------------------------------------------------------------------------------------
---- 药剂匣
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_pill_box","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_pill_box",            --  --  inst.prefab  实体名字
        { Ingredient("driftwood_log", 10) ,Ingredient("log", 10) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_pill_box.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_pill_box.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_pill_box","MODS")                       -- -- 在【模组物品】标签里移除这个。



--------------------------------------------------------------------------------------------------------------------------------------------
---- 药材袋 食物保鲜袋
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_herbal_bag","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_herbal_bag",            --  --  inst.prefab  实体名字
        { Ingredient("pigskin", 3) ,Ingredient("beefalowool", 3) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_herbal_bag.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_herbal_bag.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_herbal_bag","MODS")                       -- -- 在【模组物品】标签里移除这个。




--------------------------------------------------------------------------------------------------------------------------------------------
---- 空瓶
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_spell_empty_bottle_maker","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_spell_empty_bottle_maker",            --  --  inst.prefab  实体名字
        { Ingredient("moonglass", 5)  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_empty_bottle.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_empty_bottle.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_spell_empty_bottle_maker","MODS")                       -- -- 在【模组物品】标签里移除这个。



--------------------------------------------------------------------------------------------------------------------------------------------
---- 火荨麻 药剂瓶
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_firenettles_medicine_bottle","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_firenettles_medicine_bottle",            --  --  inst.prefab  实体名字
        { Ingredient("firenettles", 1),Ingredient("chemist_item_empty_bottle", 1)  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            numtogive = 3,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_firenettles_medicine_bottle.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_firenettles_medicine_bottle.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_firenettles_medicine_bottle","MODS")                       -- -- 在【模组物品】标签里移除这个。
--------------------------------------------------------------------------------------------------------------------------------------------
---- 火荨麻 药剂瓶（批量）
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_spell_firenettles_medicine_bottle_maker","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_spell_firenettles_medicine_bottle_maker",            --  --  inst.prefab  实体名字
        { Ingredient("firenettles", 10),Ingredient("chemist_item_empty_bottle", 10)  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            -- numtogive = 3,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_firenettles_medicine_bottle.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_firenettles_medicine_bottle.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_spell_firenettles_medicine_bottle_maker","MODS")                       -- -- 在【模组物品】标签里移除这个。

--------------------------------------------------------------------------------------------------------------------------------------------
---- 智慧 药剂瓶
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_wisdom_medicine","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_wisdom_medicine",            --  --  inst.prefab  实体名字
        { Ingredient("chemist_food_wisdom_apple", 10) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_wisdom_medicine.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_wisdom_medicine.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_wisdom_medicine","MODS")                       -- -- 在【模组物品】标签里移除这个。

--------------------------------------------------------------------------------------------------------------------------------------------
---- 金坷垃 药剂瓶
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_jinkela_medicine","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_jinkela_medicine",            --  --  inst.prefab  实体名字
        { Ingredient("compost", 1) , Ingredient("spoiled_food", 2) , Ingredient("poop", 2) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_jinkela_medicine.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_jinkela_medicine.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_jinkela_medicine","MODS")                       -- -- 在【模组物品】标签里移除这个。

--------------------------------------------------------------------------------------------------------------------------------------------
----植物生长药剂
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_plant_growth_medicine","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_plant_growth_medicine",            --  --  inst.prefab  实体名字
        { Ingredient("spoiled_food", 1) , Ingredient("poop", 1)  },
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_plant_growth_medicine.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_plant_growth_medicine.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_plant_growth_medicine","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 智慧果
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_food_wisdom_apple","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_food_wisdom_apple",            --  --  inst.prefab  实体名字
        { Ingredient(CHARACTER_INGREDIENT.SANITY, 10)  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_food_wisdom_apple.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_food_wisdom_apple.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_food_wisdom_apple","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 经验药剂 lv1
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_exp_medicine","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_exp_medicine",            --  --  inst.prefab  实体名字
        { Ingredient("red_cap", 1) ,  Ingredient("green_cap", 1) ,Ingredient("blue_cap", 1) ,  Ingredient("chemist_food_wisdom_apple", 1) ,  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_exp_medicine.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_exp_medicine.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_exp_medicine","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 经验药剂 lv2
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_exp_medicine2","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_exp_medicine2",            --  --  inst.prefab  实体名字
        { Ingredient("fig", 1) ,  Ingredient("chemist_food_wisdom_apple", 5) ,  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_exp_medicine2.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_exp_medicine2.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_exp_medicine2","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 经验药剂 lv3
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_exp_medicine3","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_exp_medicine3",            --  --  inst.prefab  实体名字
        { Ingredient("mandrake", 1) ,   Ingredient("chemist_food_wisdom_apple", 5) ,  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_exp_medicine3.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_exp_medicine3.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_exp_medicine3","MODS")                       -- -- 在【模组物品】标签里移除这个。

--------------------------------------------------------------------------------------------------------------------------------------------
---- 经验药剂 lv3 配方2
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_spell_exp_medicine3_maker","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_spell_exp_medicine3_maker",            --  --  inst.prefab  实体名字
        { Ingredient("deerclops_eyeball", 1) ,   Ingredient("chemist_food_wisdom_apple", 5) ,  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_exp_medicine3.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_exp_medicine3.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_spell_exp_medicine3_maker","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 洗点药剂
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_skill_points_reset_medicine","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_skill_points_reset_medicine",            --  --  inst.prefab  实体名字
        { Ingredient("ice", 80) ,  Ingredient("oceanfish_medium_8_inv", 1) , Ingredient("chemist_food_wisdom_apple", 2) ,  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_skill_points_reset_medicine.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_skill_points_reset_medicine.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_skill_points_reset_medicine","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 攻击药剂
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_spell_attack_power_multiplier_medicine_maker","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_spell_attack_power_multiplier_medicine_maker",            --  --  inst.prefab  实体名字
        {  Ingredient("rock_avocado_fruit", 2) ,  Ingredient("houndstooth", 2) , Ingredient("chemist_food_wisdom_apple", 2) ,  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_attack_power_multiplier_medicine_lv_1.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_attack_power_multiplier_medicine_lv_1.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_spell_attack_power_multiplier_medicine_maker","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 三维恢复药剂
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_spell_triple_recovery_medicine_maker","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_spell_triple_recovery_medicine_maker",            --  --  inst.prefab  实体名字
        { Ingredient("berries", 5) ,  Ingredient("chemist_food_wisdom_apple", 5) ,  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_triple_recovery_medicine_lv_1.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_triple_recovery_medicine_lv_1.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_spell_triple_recovery_medicine_maker","MODS")                       -- -- 在【模组物品】标签里移除这个。

--------------------------------------------------------------------------------------------------------------------------------------------
---- 复活药剂
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_spell_revival_medicine_maker","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_spell_revival_medicine_maker",            --  --  inst.prefab  实体名字
        { Ingredient(CHARACTER_INGREDIENT.HEALTH, 10)  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_revival_medicine_lv_1.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_item_revival_medicine_lv_1.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_spell_revival_medicine_maker","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 技能书
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_spell_skill_book_open","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_spell_skill_book_open",            --  --  inst.prefab  实体名字
        { }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_spell_skill_book_open.xml",
            -- atlas = GetInventoryItemAtlas("chemist_yue_ling_item_blissful_memory.tex"),
            image = "chemist_spell_skill_book_open.tex",
            sg_state = "give",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_spell_skill_book_open","MODS")                       -- -- 在【模组物品】标签里移除这个。


    
--------------------------------------------------------------------------------------------------------------------------------------------
---- 神奇蘑菇屋
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_building_mushroom_house","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_building_mushroom_house",            --  --  inst.prefab  实体名字
        { Ingredient("red_cap", 10),Ingredient("boards", 10)  }, 
        TECH.NONE, 
        {
            nounlock=true,
            no_deconstruction=true,
            builder_tag = "chemist_yue_ling",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
            placer = "chemist_building_mushroom_house_placer",                       -------- 建筑放置器   
            atlas = "images/map_icons/chemist_building_mushroom_house.xml",
            image = "chemist_building_mushroom_house.tex",
        },
        {"CHARACTER","STRUCTURES"}
    )
    RemoveRecipeFromFilter("chemist_building_mushroom_house","MODS")                       -- -- 在【模组物品】标签里移除这个。
    
--------------------------------------------------------------------------------------------------------------------------------------------
---- 月光转换器
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_building_moonshine_converter","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_building_moonshine_converter",            --  --  inst.prefab  实体名字
        { Ingredient("moonglass", 8),Ingredient("log", 10),Ingredient("goldnugget", 6)  }, 
        TECH.NONE, 
        {
            nounlock=true,
            no_deconstruction=true,
            builder_tag = "chemist_yue_ling",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
            placer = "chemist_building_moonshine_converter_placer",                       -------- 建筑放置器   
            atlas = "images/map_icons/chemist_building_moonshine_converter.xml",
            image = "chemist_building_moonshine_converter.tex",
        },
        {"CHARACTER","STRUCTURES"}
    )
    RemoveRecipeFromFilter("chemist_building_mushroom_house","MODS")                       -- -- 在【模组物品】标签里移除这个。
    
--------------------------------------------------------------------------------------------------------------------------------------------
---- 月光转换器
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("firenettles_seeds","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "firenettles_seeds",            --  --  inst.prefab  实体名字
        { Ingredient(CHARACTER_INGREDIENT.HEALTH, 5)  }, 
        TECH.NONE, 
        {
            nounlock=true,
            no_deconstruction=true,
            builder_tag = "chemist_yue_ling",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
            atlas = "images/inventoryimages/firenettles_seeds.xml",
            image = "firenettles_seeds.tex",
        },
        {"CHARACTER","GARDENING"}
    )
    RemoveRecipeFromFilter("chemist_building_mushroom_house","MODS")                       -- -- 在【模组物品】标签里移除这个。
