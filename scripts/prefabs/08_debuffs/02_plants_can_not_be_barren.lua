------------------------------------------------------------------------------------------------------------------------------------------------

    local FERTILIZER_DEFS = require("prefabs/fertilizer_nutrient_defs").FERTILIZER_DEFS

------------------------------------------------------------------------------------------------------------------------------------------------

local function OnAttached(inst,target) -- 玩家得到 debuff 的瞬间。 穿越洞穴、重新进存档 也会执行。
    inst.entity:SetParent(target.entity)
    inst.Network:SetClassifiedTarget(target)
    -- local player = inst.entity:GetParent()
    -----------------------------------------------------
    -- Pickable:MakeBarren()
    -- 
    target:AddTag("chemist_buff_can_not_be_barren")

    if target.components.pickable then
        ----- 已经枯萎的先恢复正常 function Pickable:Fertilize(fertilizer, doer)

            if target.components.pickable:CanBeFertilized() then
                target.components.pickable:Fertilize(inst)
            end

        ----- 截胡强制枯萎的API
            target.components.pickable.MakeBarren = function()
                
            end
        
        ----- 枯萎阶段： self.cycles_left == 0
            --- 官方的执行函数进入 0 的情况下，截胡+1 。避免官方的代码执行后进入0状态
            local old_pick_fn = target.components.pickable.Pick

            target.components.pickable.Pick = function(self, ...)

                if self.canbepicked and self.caninteractwith then

                    if self.transplanted and self.cycles_left ~= nil then
                        local cycles_left = math.max(0, self.cycles_left - 1)
                        if cycles_left == 0 then 
                            self.cycles_left = self.cycles_left + 1
                        end
                    end

                end

                return old_pick_fn(self, ...)
            end

    end



    -----------------------------------------------------
end

local function OnDetached(inst) -- 被外部命令  inst:RemoveDebuff 移除debuff 的时候 执行
    local player = inst.entity:GetParent()
end

local function OnUpdate(inst)
    local player = inst.entity:GetParent()



end

local function ExtendDebuff(inst)
    -- inst.countdown = 3 + (inst._level:value() < CONTROL_LEVEL and EXTEND_TICKS or math.floor(TUNING.STALKER_MINDCONTROL_DURATION / FRAMES + .5))
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("CLASSIFIED")



    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff.keepondespawn = true -- 是否保持debuff 到下次登陆
    -- inst.components.debuff:SetDetachedFn(inst.Remove)
    inst.components.debuff:SetDetachedFn(OnDetached)
    -- inst.components.debuff:SetExtendedFn(ExtendDebuff)
    -- ExtendDebuff(inst)

    -- inst:DoPeriodicTask(1, OnUpdate, nil, TheWorld.ismastersim)  -- 定时执行任务


    inst:AddComponent("fertilizer")    
    inst.components.fertilizer.fertilizervalue = TUNING.TREEGROWTH_FERTILIZE
    inst.components.fertilizer.soil_cycles = TUNING.TREEGROWTH_SOILCYCLES
    inst.components.fertilizer.withered_cycles = TUNING.TREEGROWTH_WITHEREDCYCLES
    inst.components.fertilizer:SetNutrients(FERTILIZER_DEFS.treegrowthsolution.nutrients)


    return inst
end

return Prefab("chemist_buff_plants_can_not_be_barren", fn)
