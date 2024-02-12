------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    改吹号角动作 为 和药水

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


AddStategraphState("wilson",State{
    name = "chemist_drinkable_sg_action",
    tags = { "doing", "busy", "canrotate","nointerrupt","chemist_drinking" },

    onenter = function(inst)
        if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:Enable(false)
        end
        inst.components.locomotor:Stop()

        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("horn", false)
        inst.AnimState:OverrideSymbol("horn01", "horn", "horn01")
        --- 动画总时间 2501 ms

        local item = inst.bufferedaction.invobject

        if item then
            local layer = item.replica.chemist_com_drinkable.layer
            local build = item.replica.chemist_com_drinkable.build

            if build then
                inst.AnimState:OverrideSymbol("horn01", build, layer or "horn01")
            end
        end


    end,
    timeline =
        {
            TimeEvent(21 * FRAMES, function(inst)
                inst:PerformBufferedAction()                
                -- inst.sg:RemoveStateTag("busy")
                -- inst.sg:RemoveStateTag("nointerrupt")
                inst.SoundEmitter:PlaySound("dontstarve/HUD/health_up")
            end),
            -- TimeEvent(2, function(inst)
            --     if inst.components.playercontroller ~= nil then
            --         inst.components.playercontroller:Enable(true)
            --     end                
            -- end),

        },
    events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
                inst.AnimState:ClearOverrideSymbol("horn01")
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:Enable(true)
                end
            end),
        },
    onexit = function(inst)
        inst.AnimState:ClearOverrideSymbol("horn01")
        if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:Enable(true)
        end
        inst.AnimState:ClearOverrideSymbol("horn01")
    end,
})

---------------------------------------------------------------------------------------------------------------------------------------------------------
---- 客户端上的，同 SGWilson_client.lua
    local TIMEOUT = 2
    AddStategraphState("wilson_client",State{
        name = "chemist_drinkable_sg_action",
        tags = { "doing", "busy", "canrotate","nointerrupt" ,"chemist_drinking"},
        server_states = { "chemist_drinkable_sg_action" },

        onenter = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            inst.components.locomotor:Stop()
            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(TIMEOUT)
        end,

        onupdate = function(inst)
            if inst.sg:ServerStateMatches() then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")

                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,

        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle")
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
        end,
    })