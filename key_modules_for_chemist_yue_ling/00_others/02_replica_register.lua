--- 本文件和 modmain.lua 平级。
--- 本文件集中注册  components 及其 replica 组件

-- 特别说明: components 组件不必注册，放到  /script/components 文件夹里就行了。但是这个组件只能 服务器调用（包括带洞穴的存档）
-- 组件对应的客户端组件 为 replica ，命名方式为：组件原名后面加上“_replica”
-- replica 组件必须用 函数 AddReplicableComponent 注册，参数为 组件原名（不带“_replica")
-- 示例：  inst.components.abcd  组件， 放置  abcd.lua 文件在   components 文件夹里，使用 inst:AddComponent("abcd") 添加。
---        对应的replica 文件为   abcd_replica.lua，同样放在   components 文件夹里，必须使用 AddReplicableComponent("abcd") 在 modmain 注册
---        客户端使用  inst.replica.abcd 调用 ，相关参数匹配同步 参照官方 已有组件。
--- 注意： replica 参数传送有一定的延迟，即便是在本机洞穴存档（开启延迟补偿），低延迟方案则必须走 RPC通道

-- AddReplicableComponent("npc_base_lib")  --- 示例


AddReplicableComponent("chemist_com_acceptable")  --- 关键主函数
AddReplicableComponent("chemist_com_rpc_event")  --- RPC 组件注册

AddReplicableComponent("chemist_com_drinkable")  --- 喝药剂组件

AddReplicableComponent("chemist_com_item_use_to")  --- 物品使用组件

AddReplicableComponent("chemist_com_workable")  --- 目标使用组件


AddReplicableComponent("chemist_com_level_sys")  --- 角色等级
AddReplicableComponent("chemist_com_skill_point_sys")  --- 技能点系统
