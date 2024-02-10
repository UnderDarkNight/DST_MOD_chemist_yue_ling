--------------------------------------------------------------------------------------------
------ 常用函数放 TUNING 里
--------------------------------------------------------------------------------------------
----- RPC 命名空间
TUNING["chemist_yue_ling.RPC_NAMESPACE"] = "chemist_yue_ling_RPC"


--------------------------------------------------------------------------------------------

TUNING["chemist_yue_ling.fn"] = {}
TUNING["chemist_yue_ling.fn"].GetStringsTable = function(prefab_name)
    -------- 读取文本表
    -------- 如果没有当前语言的问题，调取中文的那个过去
    -------- 节省重复调用运算处理
    if TUNING["chemist_yue_ling.fn"].GetStringsTable_last_prefab_name == prefab_name then
        return TUNING["chemist_yue_ling.fn"].GetStringsTable_last_table or {}
    end


    local LANGUAGE = "ch"
    if type(TUNING["chemist_yue_ling.Language"]) == "function" then
        LANGUAGE = TUNING["chemist_yue_ling.Language"]()
    elseif type(TUNING["chemist_yue_ling.Language"]) == "string" then
        LANGUAGE = TUNING["chemist_yue_ling.Language"]
    end
    local ret_table = prefab_name and TUNING["chemist_yue_ling.Strings"][LANGUAGE] and TUNING["chemist_yue_ling.Strings"][LANGUAGE][tostring(prefab_name)] or nil
    if ret_table == nil and prefab_name ~= nil then
        ret_table = TUNING["chemist_yue_ling.Strings"]["ch"][tostring(prefab_name)]
    end

    ret_table = ret_table or {}
    TUNING["chemist_yue_ling.fn"].GetStringsTable_last_prefab_name = prefab_name
    TUNING["chemist_yue_ling.fn"].GetStringsTable_last_table = ret_table

    return ret_table
end


--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------