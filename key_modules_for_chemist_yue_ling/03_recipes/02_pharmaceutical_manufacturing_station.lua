--------------------------------------------------------------------------------------------------------------------------------------------
--- 健康检查机及其科技
--------------------------------------------------------------------------------------------------------------------------------------------




----------------------------------------------------------------------------------------------------------------------------------------
------- 加载和创建个专属建造标签，并靠近才能使用。
                        ------- 科技要单独设置添加
                        -- table.insert(Assets,      Asset("ATLAS", "images/quagmire_hud.xml")                         )     --  -- 载入贴图文件
                        -- table.insert(Assets,      Asset("IMAGE", "images/quagmire_hud.tex")                         )     --  -- 载入贴图文件
                        -- RegisterInventoryItemAtlas("images/quagmire_hud.xml", "images/quagmire_hud.tex")                -- 注册贴图文件【必须要做】

                        --------- 添加活动tag给指定的 prefab，不能大写。 制作栏 左上角 的图标 和 鼠标过去的文字
                        PROTOTYPER_DEFS["chemist_building_pharmaceutical_manufacturing_station"] = {      ----- 必须是 prefab 的名字
                            icon_atlas ="images/map_icons/chemist_building_pharmaceutical_manufacturing_station.xml", 
                            icon_image = "chemist_building_pharmaceutical_manufacturing_station.tex",	
                            is_crafting_station = true,
                            -- action_str = "TRADE",
                            action_str = "USE",
                            filter_text = "  "
                        } -- 正常
                        ----------------------------------------------------------------------------------------
                        RECIPETABS[string.upper("chemist_building_pharmaceutical_manufacturing_station")] = { 
                            str = string.upper("chemist_building_pharmaceutical_manufacturing_station"),
                            sort = 999, 
                            icon = "chemist_building_pharmaceutical_manufacturing_station.tex", 
                            icon_atlas = "images/map_icons/chemist_building_pharmaceutical_manufacturing_station.xml", 
                            crafting_station = true,
                            shop = true
                        }
                        ----------------------------------------------------------------------------------------
                        local TechTree = require("techtree")
                        TechTree.Create_____temp_old = TechTree.Create
                        TechTree.Create = function(t)
                            t = t or {}
                            for i, v in ipairs(TechTree.AVAILABLE_TECH) do
                                t[v] = t[v] or 0
                            end
                            return t
                        end

                        table.insert(TechTree.AVAILABLE_TECH,string.upper("chemist_building_pharmaceutical_manufacturing_station")) ---- 添加到科技树
                        table.insert(TechTree.BONUS_TECH,string.upper("chemist_building_pharmaceutical_manufacturing_station")) ---- 有奖励的科技树

                        -------------------- 科技参数
                        TECH.NONE[string.upper("chemist_building_pharmaceutical_manufacturing_station")] = 0
                        -- for k, v in pairs(TECH) do
                        --     TECH[k][string.upper("chemist_building_pharmaceutical_manufacturing_station")] = 0
                        -- end
                        TECH[string.upper("chemist_building_pharmaceutical_manufacturing_station")] = {
                            [string.upper("chemist_building_pharmaceutical_manufacturing_station")] = 1,
                        }
                        for k,v in pairs(TUNING.PROTOTYPER_TREES) do    ---------- 给其他标签注入0参数
                            v[string.upper("chemist_building_pharmaceutical_manufacturing_station")] = 0
                        end

                        TUNING.PROTOTYPER_TREES[string.upper("chemist_building_pharmaceutical_manufacturing_station")] = TechTree.Create({   ---- 靠近inst 的时候触发科技树标记位切换
                            [string.upper("chemist_building_pharmaceutical_manufacturing_station")] = 1,
                        })

                        ------- 给其他的添加科技类别 --- TECH.NONE  ---- 这个可能就是 builder_replica 造成崩溃的原因
                        for i, v in pairs(AllRecipes) do
                            if v.level[string.upper("chemist_building_pharmaceutical_manufacturing_station")] == nil then
                                v.level[string.upper("chemist_building_pharmaceutical_manufacturing_station")] = 0
                            end
                        end
                        TechTree.Create = TechTree.Create_____temp_old
                        TechTree.Create_____temp_old = nil


--------------------------------------------------------------------------------------------------------------------------------------------
---- 制作站
--------------------------------------------------------------------------------------------------------------------------------------------
    AddRecipeToFilter("chemist_building_pharmaceutical_manufacturing_station","CHARACTER")     ---- 添加物品到目标标签
    AddRecipe2(
        "chemist_building_pharmaceutical_manufacturing_station",            --  --  inst.prefab  实体名字
        { Ingredient("boards", 10),Ingredient("cutstone", 10),Ingredient("goldnugget", 10) }, 
        TECH.NONE, --- TECH.NONE
        {
            nounlock=true,
            -- no_deconstruction=true,
            builder_tag = "chemist_yue_ling",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
            placer = "chemist_building_pharmaceutical_manufacturing_station_placer",                       -------- 建筑放置器        
            atlas = "images/map_icons/chemist_building_pharmaceutical_manufacturing_station.xml",
            image = "chemist_building_pharmaceutical_manufacturing_station.tex",
        },
        {"CHARACTER"}
    )
    RemoveRecipeFromFilter("chemist_building_pharmaceutical_manufacturing_station","MODS")                       -- -- 在【模组物品】标签里移除这个。
--------------------------------------------------------------------------------------------------------------------------------------------
    local function Add_Recipe_2_Machine(cmd_table)
    -- cmd_table = {
    --     prefab = "",
    --     Ingredients = {},
    --     atlas = "",
    --     image = "",
    --     placer = "",
    --     builder_tag = "",
    --     numtogive = 1,
    --     actionstr = "",      --- 文本文字
    --     sg_state = "",       --- sg
    -- }
    AddRecipeToFilter(cmd_table.prefab,string.upper("chemist_building_pharmaceutical_manufacturing_station")) 
    AddRecipe2(
        cmd_table.prefab,            --  --  inst.prefab  实体名字
        cmd_table.Ingredients or {}, 
        -- TECH[string.upper("chemist_building_pharmaceutical_manufacturing_station")], --- TECH.NONE
        TECH.NONE, --- TECH.NONE
        {
            nounlock=true,
            no_deconstruction=true,
            atlas = cmd_table.atlas,
            image = cmd_table.image,
            placer = cmd_table.placer,
            builder_tag = cmd_table.builder_tag,
            numtogive = cmd_table.numtogive,
            sg_state = cmd_table.sg_state,
            actionstr = cmd_table.actionstr,
            station_tag = "chemist_building_pharmaceutical_manufacturing_station",
        },
        {string.upper("chemist_building_pharmaceutical_manufacturing_station")}
    )
    RemoveRecipeFromFilter(cmd_table.prefab,"MODS")                       -- -- 在【模组物品】标签里移除这个。
    end

--------------------------------------------------------------------------------------------------------------------------------------------
--- 空瓶子
--------------------------------------------------------------------------------------------------------------------------------------------
    Add_Recipe_2_Machine({
        prefab = "chemist_item_empty_bottle",
        Ingredients = { Ingredient("moonglass", 5)  },
        -- builder_tag = "fwd_in_pdt_test33333333333366666",
        atlas = "images/inventoryimages/chemist_item_empty_bottle.xml",
        image = "chemist_item_empty_bottle.tex",
    })

-- --------------------------------------------------------------------------------------------------------------------------------------------
-- --- 火荨麻药剂
-- --------------------------------------------------------------------------------------------------------------------------------------------
--     Add_Recipe_2_Machine({
--         prefab = "chemist_item_firenettles_medicine_bottle",
--         Ingredients = { Ingredient("firenettles", 1),Ingredient("ash", 1),Ingredient("chemist_item_empty_bottle", 1)  },
--         -- builder_tag = "fwd_in_pdt_test33333333333366666",
--         atlas = "images/inventoryimages/chemist_item_firenettles_medicine_bottle.xml",
--         image = "chemist_item_firenettles_medicine_bottle.tex",
--     })

--------------------------------------------------------------------------------------------------------------------------------------------
--- 通用恢复药剂 
--------------------------------------------------------------------------------------------------------------------------------------------
    Add_Recipe_2_Machine({
        prefab = "chemist_item_restorative_medicine_bottle",
        Ingredients = { Ingredient("spidergland", 1),Ingredient("honey", 1),Ingredient("chemist_food_wisdom_apple", 1),Ingredient("chemist_item_empty_bottle", 1)  },
        -- builder_tag = "fwd_in_pdt_test33333333333366666",
        atlas = "images/inventoryimages/chemist_item_restorative_medicine_bottle.xml",
        image = "chemist_item_restorative_medicine_bottle.tex",
    })

--------------------------------------------------------------------------------------------------------------------------------------------
--- 可乐 
--------------------------------------------------------------------------------------------------------------------------------------------
    Add_Recipe_2_Machine({
        prefab = "chemist_item_cola_soda",
        Ingredients = { Ingredient("ice", 2) , Ingredient("chemist_food_wisdom_apple", 1),Ingredient("chemist_item_empty_bottle", 1)  },
        -- builder_tag = "fwd_in_pdt_test33333333333366666",
        atlas = "images/inventoryimages/chemist_item_cola_soda.xml",
        image = "chemist_item_cola_soda.tex",
    })

--------------------------------------------------------------------------------------------------------------------------------------------
--- 植物生长药剂 
--------------------------------------------------------------------------------------------------------------------------------------------
    Add_Recipe_2_Machine({
        prefab = "chemist_item_plant_growth_medicine",
        Ingredients = { Ingredient("glommerfuel", 1) , Ingredient("spoiled_food", 1) , Ingredient("poop", 1), Ingredient("chemist_item_empty_bottle", 1)  },
        -- builder_tag = "fwd_in_pdt_test33333333333366666",
        atlas = "images/inventoryimages/chemist_item_plant_growth_medicine.xml",
        image = "chemist_item_plant_growth_medicine.tex",
    })
