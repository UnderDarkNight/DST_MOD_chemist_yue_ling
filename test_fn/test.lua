
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
        -- local inst  = ThePlayer.components.inventory:GetActiveItem()
        -- print(inst)
        -- ThePlayer.components.inventory:DropActiveItem()
    ----------------------------------------------------------------------------------------------------------------
        -- print(ThePlayer.components.inventory:IsHeavyLifting())
        -- for k, v in pairs(forest_network.components.worldtemperature) do
        --     print(k,v)
        -- end
        -- local inst = TheSim:FindFirstEntityWithTag("chemist_yue_ling_equipment_cape")
        -- print(inst)
        -- inst.replica.container:Open(ThePlayer)
    ----------------------------------------------------------------------------------------------------------------
            -- for k, v in pairs(TUNING["chemist_yue_ling.equippable"]) do
            --     print(k,v)
            -- end
            -- print(TUNING["chemist_yue_ling.equippable"]:GetAmuletSlot())
    ----------------------------------------------------------------------------------------------------------------
            -- local npc = SpawnPrefab("woodie")
            -- npc.Transform:SetPosition(x, y, z)
            -- npc.components.health:Kill()
    ----------------------------------------------------------------------------------------------------------------
        -- local spriter_big = SpawnPrefab("chemist_yue_ling_fx_spriter_big")
        -- spriter_big.components.chemist_yue_ling_com_linearcircler:SetCircleTarget(ThePlayer)
        -- spriter_big.components.chemist_yue_ling_com_linearcircler:Start()
        -- spriter_big.components.chemist_yue_ling_com_linearcircler.randAng = 0.125
        -- spriter_big.components.chemist_yue_ling_com_linearcircler.clockwise = math.random(100) < 50
        -- spriter_big.components.chemist_yue_ling_com_linearcircler.distance_limit = 2.5
        -- spriter_big.components.chemist_yue_ling_com_linearcircler.setspeed = 0.2
    ----------------------------------------------------------------------------------------------------------------
            -- ThePlayer.AnimState:PlayAnimation("erd_run_loop",true)
    ----------------------------------------------------------------------------------------------------------------
            -- ThePlayer.components.chemist_yue_ling_func:RPC_PushEvent("rpc_test",{
            --     x = 100,y = 100,z = 101
            -- })
            -- ThePlayer.replica.chemist_yue_ling_func:RPC_PushEvent("rpc_test",{
            --     x = 100,y = 100,z = 101
            -- })
    ----------------------------------------------------------------------------------------------------------------
            -- 立绘测试  chemist_yue_ling_drawing_test
                -- ThePlayer:PushEvent("chemist_yue_ling.drawing.display",{
                --     bank = "chemist_yue_ling_drawing_test",
                --     build = "chemist_yue_ling_drawing_test",
                --     anim = "idle",
                --     location = 5 ,
                --     speed = 1.5,
                --     scale = 0.5,
                -- })
    ----------------------------------------------------------------------------------------------------------------
        -- --- 精灵调试

        --     if ThePlayer.__spriter then
        --         ThePlayer.__spriter:Remove()
        --     end

        --     ThePlayer.__spriter = SpawnPrefab("chemist_yue_ling_fx_spriter_big")
        --     ThePlayer.__spriter:PushEvent("Set",{
        --         player = ThePlayer,  --- 跟随目标
        --         range = 3,           --- 环绕点半径
        --         point_num = 15,       --- 环绕点
        --         -- new_pt_time = 0.5 ,    --- 新的跟踪点时间
        --         -- speed = 8,           --- 强制固定速度
        --         speed_mult = 2,      --- 速度倍速
        --         next_pt_dis = 0.5,      --- 触碰下一个点的距离
        --         speed_soft_delta = 20, --- 软增加
        --         y = 1.5,
        --         tail_time = 0.2,
        --     })
    ----------------------------------------------------------------------------------------------------------------
            -- SpawnPrefab("chemist_yue_ling_fx_sharp"):PushEvent("Set",{
            --     target = ThePlayer                
            -- })
    ----------------------------------------------------------------------------------------------------------------
    -----   等级系统
                -- if not TheNet:IsDedicated() then
                --     ThePlayer.replica.chemist_yue_ling_level_sys:AddClientSideUpdateFn(function(num)
                --         print("level client side",num)
                --     end)
                -- else
                --     ThePlayer.components.chemist_yue_ling_level_sys:LevelUp()
                -- end

                -- ThePlayer.components.chemist_yue_ling_level_sys:LevelUp()

    ----------------------------------------------------------------------------------------------------------------

    ----------------------------------------------------------------------------------------------------------------
        --  SpawnPrefab("chemist_yue_ling_fx_shadow_pillar"):PushEvent("Set",{
        --     pt = Vector3(x,y,z),
        --     time = 3,
        --     warningtime = 2,
        --  })
    ----------------------------------------------------------------------------------------------------------------
            -- if ThePlayer.PushEvent_old == nil then
            --     ThePlayer.PushEvent_old = ThePlayer.PushEvent
            --     ThePlayer.PushEvent = function(self,event,...)
            --         print("player event",event)
            --         return self.PushEvent_old(self,event,...)
            --     end
            -- end
            -- ThePlayer.components.chemist_yue_ling_level_sys:DoDelta(2)

            -- if TheWorld.PushEvent_old == nil then
            --     TheWorld.PushEvent_old = TheWorld.PushEvent
            --     TheWorld.PushEvent = function(self,event,...)
            --         print("world event",event)
            --         return self.PushEvent_old(self,event,...)
            --     end
            -- else
            --     TheWorld.PushEvent = TheWorld.PushEvent_old
            -- end

    ----------------------------------------------------------------------------------------------------------------
                -- ThePlayer.HUD:chemist_yue_ling_powerbar_show()
                -- -- if not ThePlayer.replica.chemist_yue_ling_level_sys then
                -- --     return
                -- -- end
                -- -- if not ThePlayer.replica.chemist_yue_ling_resolve_power then
                -- --     return
                -- -- end
                -- print("chemist_yue_ling_level_sys",ThePlayer.replica.chemist_yue_ling_level_sys)
                -- print("chemist_yue_ling_resolve_power",ThePlayer.replica.chemist_yue_ling_resolve_power)

                -- ThePlayer.HUD:chemist_yue_ling_powerbar_show(function(root)
                --     -- bar:SetPosition(15,-24)

                --     local lv_text_2 = root:AddChild(Text(CODEFONT,30,"Lv.50",{ 255/255 , 255/255 ,255/255 , 1}))
                --     lv_text_2:SetPosition(-(20-1.5),18.5)

                --     local lv_text = root:AddChild(Text(CODEFONT,30,"Lv.50",{ 102/255 , 255/255 ,102/255 , 1}))
                --     lv_text:SetPosition(-20,20)



                --     local num_text_2 = root:AddChild(Text(CODEFONT,30,"100",{ 255/255 , 255/255 ,255/255 , 1}))
                --     num_text_2:SetPosition(15+1.5,-(24+1.5))

                --     local num_text = root:AddChild(Text(CODEFONT,30,"100",{ 0/255 , 0/255 ,0/255 , 1}))
                --     num_text:SetPosition(15,-24)

                -- end)
    ----------------------------------------------------------------------------------------------------------------
    ---- 击飞屏蔽
                -- ThePlayer:ListenForEvent("newstate",function(_,_table)
                --     if _table == nil then
                --         return
                --     end

                --     print("newstate",_table.statename)
                -- end)
                -- ThePlayer:ListenForEvent("newstate",function(_,_table)
                --     if _table == nil then
                --         return
                --     end

                --     -- print("newstate",_table.statename)
                --     if _table.statename == "knockback" then
                --         ThePlayer.sg:GoToState("idle")
                --     end

                -- end)
    ----------------------------------------------------------------------------------------------------------------
    -- --- 褪色的记忆
    --         SpawnPrefab("chemist_yue_ling_projectile_faded_memory"):PushEvent("Set",{
    --             pt = Vector3(x+10,0,z+10),
    --             -- y = 3,
    --             tail_time = 0.3,
    --             speed = 8,
    --         })
    ----------------------------------------------------------------------------------------------------------------
    --- 技能特效
            -- SpawnPrefab("chemist_yue_ling_fx_scythe_attack"):PushEvent("Set",{
            --     pt = Vector3(x,y,z),
            --     speed = 2,
            --     scale = 3,
            -- })
    ----------------------------------------------------------------------------------------------------------------
        -- ThePlayer.components.playercontroller:DoAction(BufferedAction(ThePlayer, nil, ACTIONS.chemist_yue_ling_SCYTHE_SPELL_ACTION))
        ThePlayer.components.chemist_yue_ling_func:RPC_PushEvent("chemist_yue_ling_spell_sound_client","dontstarve/common/together/celestial_orb/active")
        -- ThePlayer:ListenForEvent("chemist_yue_ling_spell_sound_client",function(_,addr)
        --     print("chemist_yue_ling_spell_sound_client",addr)
        -- end)
        -- TheFrontEnd:GetSound():PlaySound("dontstarve/common/together/celestial_orb/active")
    ----------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))