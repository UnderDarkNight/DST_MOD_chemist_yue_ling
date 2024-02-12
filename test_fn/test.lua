
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ 界面调试
    local Widget = require "widgets/widget"
    local Image = require "widgets/image" -- 引入image控件
    local UIAnim = require "widgets/uianim"


    local Screen = require "widgets/screen"
    local AnimButton = require "widgets/animbutton"
    local ImageButton = require "widgets/imagebutton"
    local Menu = require "widgets/menu"
    local Text = require "widgets/text"
    local TEMPLATES = require "widgets/redux/templates"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local flg,error_code = pcall(function()
    print("WARNING:PCALL START +++++++++++++++++++++++++++++++++++++++++++++++++")
    local x,y,z =    ThePlayer.Transform:GetWorldPosition()  
    ----------------------------------------------------------------------------------------------------------------    ----------------------------------------------------------------------------------------------------------------
    ---- GetDapperness 调试
        -- 初始自带回san效果，三秒回复1点，添加紫宝石提升回san效果，每添加一颗提升0.5，最高每三秒回复6点（十颗紫宝石+初始1点，合计6点）
        -- 消耗紫色宝石：50
        -- 每分钟： 20 -> 120
        --- y = 2*x + 20
        
        -- local inst = TheSim:FindFirstEntityWithTag("chemist_equipment_sublime_backpack")
        -- inst.components.equippable.GetDapperness = function()
        --     -- return 20/60
        --     return 120/60
        -- end
    ----------------------------------------------------------------------------------------------------------------
    --- RPC 信道测试
            
            -- ThePlayer.components.chemist_com_rpc_event:PushEvent("rpc_test_data_from_server",1)
            -- for i = 1, 10, 1 do
            --     ThePlayer.components.chemist_com_rpc_event:PushEvent("rpc_test_data_from_server",i)                
            -- end

            -- ThePlayer.replica.chemist_com_rpc_event:PushEvent("rpc_test_data_from_client",1)
            -- for i = 1, 10, 1 do
            --     ThePlayer.replica.chemist_com_rpc_event:PushEvent("rpc_test_data_from_client",i)
                
            -- end

    ----------------------------------------------------------------------------------------------------------------
    ---- 启蒙状态

                -- print(ThePlayer.components.sanity:IsLunacyMode())

    ----------------------------------------------------------------------------------------------------------------
    --- 
        -- ThePlayer.components.chemist_com_level_sys:LevelUp(200)
        -- ThePlayer.components.chemist_com_level_sys:Add_Exp(100)
        -- local current_level = 1

        -- for i = 1, 50, 1 do
        --     local nex_level_exp = math.floor(current_level/10) + 1
        --     print("Current:",current_level,"NextEXP:",nex_level_exp)
        --     current_level = current_level + 1
        -- end

        -- local old_level = 10
        -- local new_level = 11
        -- for i = old_level+1, new_level, 1 do
        --     print(i)
        -- end

        ThePlayer.components.chemist_com_level_sys:LevelUp(15)

        -- local current_level = ThePlayer.replica.chemist_com_level_sys:GetCurrentLevel()
        -- local max_level = ThePlayer.replica.chemist_com_level_sys:GetMaxLevel()
        -- local current_exp = ThePlayer.replica.chemist_com_level_sys:GetCurrentExp()
        -- local next_level_exp = ThePlayer.replica.chemist_com_level_sys:GetNextLevelExp()
        -- print("Current:",current_level,"Max:",max_level,"Exp:",current_exp,"NextEXP:",next_level_exp)


        -- for k, v in pairs(ThePlayer.children) do
        --     print(k,v)
        -- end

        -- print(ThePlayer.GUID)
        -- SpawnPrefab("chemist_other_level_classified").__net_classified_entity_target:set(ThePlayer)

        -- ThePlayer.replica.chemist_com_level_sys.classified.__net_classified_entity_target:set(ThePlayer)

        -- print(ThePlayer.replica.chemist_com_level_sys.classified)

        -- local inst = TheSim:FindFirstEntityWithTag("chemist_other_level_classified")
        -- inst:Remove()

        -- ThePlayer:SpawnChild("chemist_other_level_classified")
        -- print(ThePlayer.chemist_other_level_classified)

        -- ThePlayer.replica.chemist_com_level_sys.temp_inst.__net_classified_entity_target:set(ThePlayer)

        -- print()
    ----------------------------------------------------------------------------------------------------------------
    ----    绚丽之门 事件追踪
            -- ThePlayer:ListenForEvent("newstate",function(_,_table)
            --     if _table and _table.statename then
            --         print("+++",_table.statename)
            --     end
            -- end)
            -- ThePlayer.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_jacob")
            -- ThePlayer.SoundEmitter:PlaySound("dontstarve/HUD/hunger_up")
            -- ThePlayer.SoundEmitter:PlaySound("dontstarve/HUD/health_up")
--             [00:57:22]: 
-- [00:57:22]: dontstarve/HUD/health_up
    ----------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))