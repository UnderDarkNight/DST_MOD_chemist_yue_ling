--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    快捷键

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        local keys  = {
            KEY_A = 97,
            KEY_B = 98,
            KEY_C = 99,
            KEY_D = 100,
            KEY_E = 101,
            KEY_F = 102,
            KEY_G = 103,
            KEY_H = 104,
            KEY_I = 105,
            KEY_J = 106,
            KEY_K = 107,
            KEY_L = 108,
            KEY_M = 109,
            KEY_N = 110,
            KEY_O = 111,
            KEY_P = 112,
            KEY_Q = 113,
            KEY_R = 114,
            KEY_S = 115,
            KEY_T = 116,
            KEY_U = 117,
            KEY_V = 118,
            KEY_W = 119,
            KEY_X = 120,
            KEY_Y = 121,
            KEY_Z = 122,
            KEY_F1 = 282,
            KEY_F2 = 283,
            KEY_F3 = 284,
            KEY_F4 = 285,
            KEY_F5 = 286,
            KEY_F6 = 287,
            KEY_F7 = 288,
            KEY_F8 = 289,
            KEY_F9 = 290,
            KEY_F10 = 291,
            KEY_F11 = 292,
            KEY_F12 = 293,
        }

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------
        local function key_event_fn_client(inst,key,down)
            if down then
                if key == keys[TUNING["chemist_yue_ling.Config"].SKILL_BOOK_OPEN] then
                    inst:PushEvent("chemist_spell_skill_book_open")
                end
            end
        end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    
    inst:DoTaskInTime(0,function()
        

        if not (ThePlayer and inst == ThePlayer ) then
            return
        end
        ---------------------------------------------------------------------------------------------------------
        ----
            local function check_is_text_inputting()    --- 检查是否正在输入文字
                -- 代码来自  TheFrontEnd:OnTextInput
                local screen = TheFrontEnd:GetActiveScreen()
                if screen ~= nil then
                    if TheFrontEnd.forceProcessText and TheFrontEnd.textProcessorWidget ~= nil then
                        return true
                    else
                        return false
                    end
                end
                return false
            end
        ---------------------------------------------------------------------------------------------------------
        ---- key handler
            local key_handler = TheInput:AddKeyHandler(function(key,down)  ------ 30FPS
                if not check_is_text_inputting() then
                    key_event_fn_client(inst,key,down)
                end
            end)


        ---------------------------------------------------------------------------------------------------------
        ----
            inst:ListenForEvent("onremove",function()
                key_handler:Remove()
            end)
        ---------------------------------------------------------------------------------------------------------





    end)

end