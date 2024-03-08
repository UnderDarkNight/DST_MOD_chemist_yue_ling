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


    "01_empty_bottle_maker",                           --- 药剂师 制作空瓶
    "02_skill_book",                           --- 技能书打开

    "03_attack_power_multiplier_medicine_maker",                           --- 攻击药剂制作
    "04_triple_recovery_medicine_maker",                           --- 三维恢复药剂制作

    "05_firenettles_medicine_bottles_maker",                           --- 火荨麻药剂、批量

    "06_exp_medicine3_maker",                           --- 经验药剂LV3 

    "07_revival_medicine_maker",                           --- 复活药水 

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