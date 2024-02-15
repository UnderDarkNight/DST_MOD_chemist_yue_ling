
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

        -- ThePlayer.components.chemist_com_level_sys:LevelUp(15)

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
    ----------------------------------------------------------------------------------------------------------------
    --- UI 调试

        -- ThePlayer.HUD:Chemist_Skill_Book_Close()
        -- local main_scale_num = 0.6
        -- TUNING.test_ui_fn = function(root)
            

        --     -- local info_text = root:AddChild(Image())
        --     -- root.info_text = info_text
        --     -- info_text:SetTexture("images/widget/chemist_skill_book_base.xml","info_text.tex")
        --     -- info_text:SetPosition(-330,170)
        --     -- info_text:Show()
        --     -- info_text:SetScale(main_scale_num,main_scale_num,main_scale_num)

        --     -- --------- 玩家等级
        --     --     local level_text = root:AddChild(Text(CODEFONT,38,"XXX",{ 255/255 , 255/255 ,255/255 , 1}))
        --     --     level_text:SetPosition(-240,192)
        --     --     level_text:SetString("000")
        --     --     local level_num = ThePlayer.replica.chemist_com_level_sys:GetCurrentLevel()
        --     --     level_text:SetString("Lv."..tostring(level_num))
        --     -- --------- 下一级经验
        --     --     local next_level_text = root:AddChild(Text(CODEFONT,38,"XXX",{ 255/255 , 255/255 ,255/255 , 1}))
        --     --     next_level_text:SetPosition(-240,165)
        --     --     next_level_text:SetString("0/10")
        --     --     local next_level_exp = tostring( ThePlayer.replica.chemist_com_level_sys:GetNextLevelExp() or 0 )
        --     --     local current_exp = tostring( ThePlayer.replica.chemist_com_level_sys:GetCurrentExp() or 0)
        --     --     local ret_text = current_exp .. "/" .. next_level_exp
        --     --     next_level_text:SetString(ret_text)


            
        --     -- --------- 剩余技能点            
        --     --     local free_points_text = root:AddChild(Text(CODEFONT,38,"XXX",{ 255/255 , 255/255 ,255/255 , 1}))
        --     --     free_points_text:SetPosition(-240,140)
        --     --     free_points_text:SetString("000")
        --     --     local free_points = ThePlayer.replica.chemist_com_skill_point_sys.free_points or 0
        --     --     free_points_text:SetString(tostring(free_points))


        -- end
        -- ThePlayer.HUD:Chemist_Skill_Book_Open()
    ----------------------------------------------------------------------------------------------------------------
        -- ThePlayer.replica.chemist_com_skill_point_sys:PlaySound("dontstarve/common/together/celestial_orb/active")
        -- ThePlayer.replica.chemist_com_skill_point_sys.temp_sound_inst.SoundEmitter:PlaySound("dontstarve/common/together/celestial_orb/active")
        -- TheFrontEnd:GetSound():PlaySound("dontstarve/common/together/celestial_orb/active")
    ----------------------------------------------------------------------------------------------------------------
    ------
            -- SpawnPrefab("chemist_fx_explode"):PushEvent("Set",{
            --     target = ThePlayer,
            --     color = Vector3(1,0,0),
            --     MultColour_Flag = true
            -- })
    ----------------------------------------------------------------------------------------------------------------
    ----- 制作栏图标扫描
                -- for k, v in pairs(AllRecipes["chemist_spell_triple_recovery_medicine_maker"]) do
                --     print(k,v)
                -- end
                -- local file_name = "chemist_item_attack_power_multiplier_medicine_lv_"..tostring(2)..".tex"
                -- AllRecipes["chemist_spell_attack_power_multiplier_medicine_maker"].atlas = GetInventoryItemAtlas(file_name)
                -- AllRecipes["chemist_spell_attack_power_multiplier_medicine_maker"].image = file_name
    ----------------------------------------------------------------------------------------------------------------
    -----
        -- local ents = TheSim:FindEntities(x, y, z, 3, {"chemist_building_pharmaceutical_manufacturing_station"}, {"burnt"}, nil) or {}
        -- local station = ents[1]
        -- print(station)
    ----------------------------------------------------------------------------------------------------------------
    ---- 
      
        -- local beard_container = ThePlayer.replica.inventory:GetEquippedItem(EQUIPSLOTS.BEARD)
        -- print(beard_container)
        -- beard_container.components.container:Close()
    ----------------------------------------------------------------------------------------------------------------
    ----
        if ThePlayer.__spriter then
            ThePlayer.__spriter:Remove()
        end

        ThePlayer.__spriter = SpawnPrefab("chemist_buff__fx_spriter")
        ThePlayer.__spriter:PushEvent("Set",{
            player = ThePlayer,  --- 跟随目标
            range = 3,           --- 环绕点半径
            point_num = 15,       --- 环绕点
            -- new_pt_time = 0.5 ,    --- 新的跟踪点时间
            -- speed = 8,           --- 强制固定速度
            speed_mult = 2,      --- 速度倍速
            next_pt_dis = 0.5,      --- 触碰下一个点的距离
            speed_soft_delta = 20, --- 软增加
            y = 1.5,
            tail_time = 0.2,
            bank_build = "chemist_buff__fx_spriter_damage",
            bloom_off = true,
            clockwise = true,
        })
    ----------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))