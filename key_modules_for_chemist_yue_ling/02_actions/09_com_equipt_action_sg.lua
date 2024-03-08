------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    穿戴动作

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


AddStategraphState("wilson",State{
    name = "chemist_equipt_sg_action",
    tags = { },

    onenter = function(inst)

        inst:PerformBufferedAction()
        if inst.sg then
            inst.sg:GoToState("idle")
        end

    end,
    timeline =
        {


        },
    events =
        {

        },
    onexit = function(inst)

    end,
})

---------------------------------------------------------------------------------------------------------------------------------------------------------
---- 客户端上的，同 SGWilson_client.lua
    local TIMEOUT = 2
    AddStategraphState("wilson_client",State{
        name = "chemist_equipt_sg_action",
        tags = { },
        server_states = { "chemist_equipt_sg_action" },

        onenter = function(inst)

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

        end,
    })