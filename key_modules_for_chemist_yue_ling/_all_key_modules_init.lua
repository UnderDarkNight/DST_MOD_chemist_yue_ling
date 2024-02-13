-- -- -- 这个文件是给 modmain.lua 调用的总入口
-- -- -- 本lua 和 modmain.lua 平级
-- -- -- 子分类里有各自的入口
-- -- -- 注意文件路径


modimport("key_modules_for_chemist_yue_ling/00_others/__all_others_modules_init.lua") 
-- 难以归类的杂乱东西

modimport("key_modules_for_chemist_yue_ling/01_character/__all_character_modules_init.lua") 
-- 角色模块

modimport("key_modules_for_chemist_yue_ling/02_actions/__all_actions_modules_init.lua") 
-- 动作相关的模块

modimport("key_modules_for_chemist_yue_ling/03_recipes/__all_recipes_modules_init.lua") 
-- 制作栏配方、烹饪配方

modimport("key_modules_for_chemist_yue_ling/04_origin_prefabs_upgrade/__all_prefabs_init.lua") 
-- 官方prefab修改

modimport("key_modules_for_chemist_yue_ling/05_origin_components_upgrade/__all_com_init.lua") 
-- 官方component 修改

modimport("key_modules_for_chemist_yue_ling/06_widgets/__all_widgets_setup.lua") 
-- 界面UI

modimport("key_modules_for_chemist_yue_ling/07_AnimState_Hook/_All_Original_AnimState_Upgrade_Init.lua") 
-- 玩家 animstate 组件修改


