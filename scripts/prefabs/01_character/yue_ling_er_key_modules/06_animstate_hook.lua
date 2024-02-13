--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    修改 animstate

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end
    inst:DoTaskInTime(0.5,function()

        if type(inst.AnimState) ~= "table" then
            return
        end

        ------------------------------------------------------------------------------------------
        ---- 
            inst.AnimState:OverrideSymbol("wendy_idle_flower","player_idles_wendy","wendy_idle_flower")
            -- inst.AnimState:OverrideSymbol("clipboard_prop","player_notes","clipboard_prop")
        ------------------------------------------------------------------------------------------
        ---- PlayAnimation
            local old_PlayAnimation_Fn = inst.AnimState.PlayAnimation

            local PlayAnimation_Fns = {
                ["idle_inaction"] = function(self,anim,loop_flag)

                    -- inst.AnimState:PlayAnimation("notes_pre")
                    -- inst.AnimState:PushAnimation("notes_loop")
                    -- inst.AnimState:PushAnimation("notes_pst")
                    -- inst.AnimState:PushAnimation("idle_loop")
                    old_PlayAnimation_Fn(self,"idle_wendy",loop_flag)
                end,
  
            }
            inst.AnimState.PlayAnimation = function(self,anim,loop_flag)
                -- print("PlayAnimation",anim)
                if PlayAnimation_Fns[anim] then
                    PlayAnimation_Fns[anim](self,anim,loop_flag)
                    return
                end
                old_PlayAnimation_Fn(self,anim,loop_flag)
            end
        ------------------------------------------------------------------------------------------
        ---- PushAnimation
            local old_PushAnimation_Fn = inst.AnimState.PushAnimation

            inst.AnimState.PushAnimation = function(self,anim,loop_flag)
                -- print("PushAnimation",anim)
                old_PushAnimation_Fn(self,anim,loop_flag)
            end
        ------------------------------------------------------------------------------------------


    end)

end