



local CHEMIST_COM_DRINKABLE_ACTION = Action({priority = 10})   --- 距离 和 目标物体的 碰撞体积有关，为 0 也没法靠近。
CHEMIST_COM_DRINKABLE_ACTION.id = "CHEMIST_COM_DRINKABLE_ACTION"
CHEMIST_COM_DRINKABLE_ACTION.strfn = function(act) --- 客户端检查是否通过,同时返回显示字段
    return "DEFAULT"
end

CHEMIST_COM_DRINKABLE_ACTION.fn = function(act)    --- 只在服务端执行~
    local item = act.invobject
    local doer = act.doer


    if item and doer and item.components.chemist_com_drinkable then
        local replica_com = item.replica.chemist_com_drinkable or item.replica._.chemist_com_drinkable
        if replica_com and replica_com:Test(doer) then
            return item.components.chemist_com_drinkable:OnDrink(doer)
        end
    end
    return false
end
AddAction(CHEMIST_COM_DRINKABLE_ACTION)

--- 【重要笔记】AddComponentAction 函数有陷阱，一个MOD只能对一个组件添加一个动作。
--- 【重要笔记】例如AddComponentAction("USEITEM", "inventoryitem", ...) 在整个MOD只能使用一次。
--- 【重要笔记】modname 参数伪装也不能绕开。


-- AddComponentAction("EQUIPPED", "npng_com_book" , function(inst, doer, target, actions, right)    --- 装备后多个技能
-- AddComponentAction("USEITEM", "inventoryitem", function(inst, doer, target, actions, right) -- -- 一个物品对另外一个目标用的技能，物品身上有 这个com 就能触发
-- AddComponentAction("SCENE", "npng_com_book" , function(inst, doer, actions, right)-------    建筑一类的特殊交互使用
-- AddComponentAction("INVENTORY", "npng_com_book", function(inst, doer, actions, right)   ---- 拖到玩家自己身上就能用
-- AddComponentAction("POINT", "complexprojectile", function(inst, doer, pos, actions, right)   ------ 指定坐标位置用。

-- 在后续注册了，这里暂时注释掉。



AddComponentAction("INVENTORY", "chemist_com_drinkable", function(item, doer, actions, right_click)   ----
    if doer and item then        
        local chemist_com_drinkable_com = item.replica.chemist_com_drinkable or item.replica._.chemist_com_drinkable        
        if chemist_com_drinkable_com and chemist_com_drinkable_com:Test(doer) and not (doer.sg and doer.sg:HasStateTag("chemist_drinking")) then
            table.insert(actions, ACTIONS.CHEMIST_COM_DRINKABLE_ACTION)
        end        
    end
end)


AddStategraphActionHandler("wilson",ActionHandler(CHEMIST_COM_DRINKABLE_ACTION,function(player)
    local bufferaction = player:GetBufferedAction() or {}
    local item = bufferaction.invobject
    if item and item:HasTag("quick_drink") then
        return "chemist_drinkable_sg_action_quick"
    end
    return "chemist_drinkable_sg_action"
end))
AddStategraphActionHandler("wilson_client",ActionHandler(CHEMIST_COM_DRINKABLE_ACTION, function(player)    
    local bufferaction = player:GetBufferedAction() or {}
    local item = bufferaction.invobject
    if item and item:HasTag("quick_drink") then
        return "chemist_drinkable_sg_action_quick"
    end
    return "chemist_drinkable_sg_action"
end))


STRINGS.ACTIONS.CHEMIST_COM_DRINKABLE_ACTION = {
    -- DEFAULT = STRINGS.ACTIONS.UPGRADE.GENERIC
    DEFAULT = "喝下"
}



