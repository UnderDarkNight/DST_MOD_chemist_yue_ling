------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
    sg 拦截切换
]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local attack_action_hook_fn = function(self)    ----- 修改 wilson 和 wilson_client 的动作返回捕捉
    local old_ATTACK = self.actionhandlers[ACTIONS.ATTACK].deststate
    self.actionhandlers[ACTIONS.ATTACK].deststate = function(inst,action)


        -------------------------------------------------------------------------------------------------------------
        --- return sg 的状态。注意 client/server 都进行了一样的HOOK
            if inst:HasTag("chemist_yue_ling") then
                if inst:HasTag("chemist_equipment_chemical_launching_gun.equipped") and not ( inst.replica.rider and inst.replica.rider:IsRiding() ) then
                    return "chemist_gun_shoot_attack"
                end
            end
        -------------------------------------------------------------------------------------------------------------
        
        return old_ATTACK(inst, action)
    end
end
AddStategraphPostInit("wilson", attack_action_hook_fn)  ----------- 加给 主机 （成功）
AddStategraphPostInit("wilson_client", attack_action_hook_fn)    -------- 注意 inst.replica 检测，用于客机