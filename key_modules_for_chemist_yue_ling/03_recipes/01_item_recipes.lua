







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
            -- atlas = GetInventoryItemAtlas("underworld_hana_item_blissful_memory.tex"),
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
            -- atlas = GetInventoryItemAtlas("underworld_hana_item_blissful_memory.tex"),
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
        { Ingredient("driftwood_log", 10) ,Ingredient("log", 10),Ingredient("opalpreciousgem", 1) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_pill_box.xml",
            -- atlas = GetInventoryItemAtlas("underworld_hana_item_blissful_memory.tex"),
            image = "chemist_item_pill_box.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_pill_box","MODS")                       -- -- 在【模组物品】标签里移除这个。



--------------------------------------------------------------------------------------------------------------------------------------------
---- 药材袋
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_herbal_bag","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_herbal_bag",            --  --  inst.prefab  实体名字
        { Ingredient("dragon_scales", 1) ,Ingredient("bearger_fur", 1),Ingredient("opalpreciousgem", 1) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_herbal_bag.xml",
            -- atlas = GetInventoryItemAtlas("underworld_hana_item_blissful_memory.tex"),
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
            -- atlas = GetInventoryItemAtlas("underworld_hana_item_blissful_memory.tex"),
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
        { Ingredient("firenettles", 1),Ingredient("ash", 1),Ingredient("chemist_item_empty_bottle", 1)  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_firenettles_medicine_bottle.xml",
            -- atlas = GetInventoryItemAtlas("underworld_hana_item_blissful_memory.tex"),
            image = "chemist_item_firenettles_medicine_bottle.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_firenettles_medicine_bottle","MODS")                       -- -- 在【模组物品】标签里移除这个。

--------------------------------------------------------------------------------------------------------------------------------------------
---- 智慧 药剂瓶
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_item_wisdom_medicine","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_item_wisdom_medicine",            --  --  inst.prefab  实体名字
        { Ingredient("powcake", 1) , Ingredient("chemist_food_wisdom_apple", 10) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_wisdom_medicine.xml",
            -- atlas = GetInventoryItemAtlas("underworld_hana_item_blissful_memory.tex"),
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
        { Ingredient("glommerfuel", 2) , Ingredient("spoiled_food", 5) , Ingredient("poop", 5) }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_item_jinkela_medicine.xml",
            -- atlas = GetInventoryItemAtlas("underworld_hana_item_blissful_memory.tex"),
            image = "chemist_item_jinkela_medicine.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_item_jinkela_medicine","MODS")                       -- -- 在【模组物品】标签里移除这个。


--------------------------------------------------------------------------------------------------------------------------------------------
---- 智慧果
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_food_wisdom_apple","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_food_wisdom_apple",            --  --  inst.prefab  实体名字
        { Ingredient(CHARACTER_INGREDIENT.SANITY, 5)  }, 
        TECH.NONE, 
        {
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",
            atlas = "images/inventoryimages/chemist_food_wisdom_apple.xml",
            -- atlas = GetInventoryItemAtlas("underworld_hana_item_blissful_memory.tex"),
            image = "chemist_food_wisdom_apple.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_food_wisdom_apple","MODS")                       -- -- 在【模组物品】标签里移除这个。

