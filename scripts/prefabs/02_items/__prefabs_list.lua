----------------------------------------------------
--- 本文件单纯返还路径
----------------------------------------------------

-- local function sum(a, b)
--     return a + b
-- end

-- local info = debug.getinfo(sum)

-- for k,v in pairs(info) do
--         print(k,':', info[k])
-- end

--------------------------------------------------------------------------
local addr_test = debug.getinfo(1).source           ---- 找到绝对路径

local temp_str_index = string.find(addr_test, "scripts/prefabs/")
local temp_addr = string.sub(addr_test,temp_str_index,-1)
-- print("fake error 6666666666666:",temp_addr)    ---- 找到本文件所处的相对路径

local temp_str_index2 = string.find(temp_addr,"/__prefabs_list.lua")

local Prefabs_addr_base = string.sub(temp_addr,1,temp_str_index2) .. "/"    --- 得到最终文件夹路径

---------------------------------------------------------------------------
-- local Prefabs_addr_base = "scripts/prefabs/01_chemist_yue_ling_items/"               --- 文件夹路径
local prefabs_name_list = {


    "01_firenettles_medicine_bottle",           --- 火荨麻 药剂瓶
    "02_empty_bottle",                          -- 空药剂瓶
    "03_herbal_bag",                            -- 药材袋
    "04_pillbox",                               -- 药剂匣
    "05_restorative_medicine_bottle",           -- 通用恢复药水
    "06_cola_soda",                             -- 可乐
    "07_plant_growth_medicine",                 -- 植物生长药剂
    "08_wisdom_medicine",                       -- 智慧药剂
    "09_jinkela_medicine",                      -- 金坷垃药剂
    "10_exp_medicine",                          -- 经验药剂

    "11_attack_power_multiplier_medicine",              -- 伤害倍增药剂
    "12_triple_recovery_medicine",              -- 三维恢复药剂

    "13_skill_points_reset_medicine",              -- 技能点重置药剂

    "14_revival_medicine",              -- 复活药水

}

---------------------------------------------------------------------------
---- 正在测试的物品
if TUNING.chemist_yue_ling_DEBUGGING_MODE == true then
    local debugging_name_list = {



    }
    for k, temp in pairs(debugging_name_list) do
        table.insert(prefabs_name_list,temp)
    end
end
---------------------------------------------------------------------------












local ret_addrs = {}
for i, v in ipairs(prefabs_name_list) do
    table.insert(ret_addrs,Prefabs_addr_base..v..".lua")
end
return ret_addrs