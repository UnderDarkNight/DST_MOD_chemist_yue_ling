------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    角色基础初始化

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



local function Language_check()
    local language = "en"
    if type(TUNING["chemist_yue_ling.Language"]) == "function" then
        language = TUNING["chemist_yue_ling.Language"]()
    elseif type(TUNING["chemist_yue_ling.Language"]) == "string" then
        language = TUNING["chemist_yue_ling.Language"]
    end
    return language
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色立绘大图
    GLOBAL.PREFAB_SKINS["chemist_yue_ling"] = {
        "chemist_yue_ling_none",
    }
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色选择时候都文本
    if Language_check() == "ch" then
        -- The character select screen lines  --人物选人界面的描述
        STRINGS.CHARACTER_TITLES["chemist_yue_ling"] = "月玲儿"
        STRINGS.CHARACTER_NAMES["chemist_yue_ling"] = "月玲儿"
        STRINGS.CHARACTER_DESCRIPTIONS["chemist_yue_ling"] = "热爱药剂的可爱少女"
        STRINGS.CHARACTER_QUOTES["chemist_yue_ling"] = "要不要来点药剂？"

        -- Custom speech strings  ----人物语言文件  可以进去自定义
        -- STRINGS.CHARACTERS[string.upper("chemist_yue_ling")] = require "speech_chemist_yue_ling"

        -- The character's name as appears in-game  --人物在游戏里面的名字
        STRINGS.NAMES[string.upper("chemist_yue_ling")] = "月玲儿"
        STRINGS.SKIN_NAMES["chemist_yue_ling_none"] = "月玲儿"  --检查界面显示的名字

        --生存几率
        STRINGS.CHARACTER_SURVIVABILITY["chemist_yue_ling"] = "容易？"
    else
        -- The character select screen lines  --人物选人界面的描述
        STRINGS.CHARACTER_TITLES["chemist_yue_ling"] = "Chemist Yue Ling Er"
        STRINGS.CHARACTER_NAMES["chemist_yue_ling"] = "Chemist Yue Ling Er"
        STRINGS.CHARACTER_DESCRIPTIONS["chemist_yue_ling"] = "Potions are the ladder of human progress"
        STRINGS.CHARACTER_QUOTES["chemist_yue_ling"] = "Want to take some potions？"

        -- Custom speech strings  ----人物语言文件  可以进去自定义
        -- STRINGS.CHARACTERS[string.upper("chemist_yue_ling")] = require "speech_chemist_yue_ling"

        -- The character's name as appears in-game  --人物在游戏里面的名字
        STRINGS.NAMES[string.upper("chemist_yue_ling")] = "Chemist Yue Ling Er"
        STRINGS.SKIN_NAMES["chemist_yue_ling_none"] = "Chemist Yue Ling Er"  --检查界面显示的名字

        --生存几率
        STRINGS.CHARACTER_SURVIVABILITY["chemist_yue_ling"] = "easy"

    end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
------增加人物到mod人物列表的里面 性别为女性（ MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL）
    AddModCharacter("chemist_yue_ling", "MALE")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----选人界面人物三维显示
    TUNING[string.upper("chemist_yue_ling").."_HUNGER"] = 30
    TUNING[string.upper("chemist_yue_ling").."_SANITY"] = 80
    TUNING[string.upper("chemist_yue_ling").."_HEALTH"] = 30


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----选人界面初始物品显示，物品相关的prefab
    TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[string.upper("chemist_yue_ling")] = {"chemist_equipment_chemical_launching_gun",
                                                                                                                                        "chemist_equipment_sublime_backpack",
                                                                                                                                        "chemist_item_firenettles_medicine_bottle",
                                                                                                                                        "chemist_item_cola_soda",}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
