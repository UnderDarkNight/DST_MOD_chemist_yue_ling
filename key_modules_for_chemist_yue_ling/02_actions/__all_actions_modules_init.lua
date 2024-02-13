-- -- 这个文件是给 modmain.lua 调用的总入口
-- -- 本lua 和 modmain.lua 平级
-- -- 子分类里有各自的入口
-- -- 注意文件路径


modimport("key_modules_for_chemist_yue_ling/02_actions/01_atk_action_hook_for_gun.lua")  --- 枪攻击动作hook

modimport("key_modules_for_chemist_yue_ling/02_actions/02_gun_shoot_action_sg.lua")  --- 枪攻击动作sg


modimport("key_modules_for_chemist_yue_ling/02_actions/03_item_acceptable.lua")  --- 物品接受交互

modimport("key_modules_for_chemist_yue_ling/02_actions/04_drinkable_com_action.lua")  --- 喝药剂 交互注册
modimport("key_modules_for_chemist_yue_ling/02_actions/05_drinkable_sg_action.lua")  --- 喝药剂 sg
modimport("key_modules_for_chemist_yue_ling/02_actions/06_drinkable_sg_action_quick.lua")  --- 喝药剂 sg quick

modimport("key_modules_for_chemist_yue_ling/02_actions/07_com_action_item_use_to.lua")  --- 物品使用组件
modimport("key_modules_for_chemist_yue_ling/02_actions/08_com_action_workable.lua")  --- 目标使用组件