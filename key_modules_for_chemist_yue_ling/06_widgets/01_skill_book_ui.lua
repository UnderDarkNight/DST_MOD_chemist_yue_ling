------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[



]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Widget = require "widgets/widget"
local Image = require "widgets/image" -- 引入image控件
local UIAnim = require "widgets/uianim"


local Screen = require "widgets/screen"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"


AddPlayerPostInit(function(inst)
    inst:DoTaskInTime(0,function()
        if inst and ThePlayer and inst == ThePlayer and inst.HUD and inst:HasTag("chemist_yue_ling") then
            inst:ListenForEvent("chemist_spell_skill_book_open",function()
                inst.HUD:Chemist_Skill_Book_Open()
            end)
        end
    end)
end)

local current_dsp_page_num = 1

AddClassPostConstruct("screens/playerhud",function(self)
    local hud = self

    function self:Chemist_Skill_Book_Open()
        if self.__chemist_skill_book_widget then
            self.__chemist_skill_book_widget:Kill()
            self.__chemist_skill_book_widget = nil
            return
        end
        ----------------------------------------------------------------
            local root = self:AddChild(Screen())
            self.__chemist_skill_book_widget = root

        ----------------------------------------------------------------
            local main_scale_num = 0.6
        -------- 设置锚点
            root:SetHAnchor(0) -- 设置原点x坐标位置，0、1、2分别对应屏幕中、左、右
            root:SetVAnchor(0) -- 设置原点y坐标位置，0、1、2分别对应屏幕中、上、下
            root:SetPosition(0,0)
            root:MoveToBack()
            root:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)   --- 缩放模式
        -------- 添加主背景 
            local background = root:AddChild(Image())
            root.background = background
            background:SetTexture("images/widget/chemist_skill_book_base.xml","background.tex")
            background:SetPosition(0,0)
            background:Show()
            background:SetScale(main_scale_num,main_scale_num,main_scale_num)
        ----------------------------------------------------------------
        ------- 关闭按钮
            local close_button = root:AddChild(ImageButton(
                "images/widget/chemist_skill_book_base.xml",
                "close_button.tex",
                "close_button.tex",
                "close_button.tex",
                "close_button.tex",
                "close_button.tex"
            ))
            root.close_button = close_button
            close_button:SetScale(main_scale_num,main_scale_num,main_scale_num)
            close_button:SetPosition(350,200)
            close_button:SetOnClick(function()
                hud:Chemist_Skill_Book_Close()
            end)
        ----------------------------------------------------------------
        ----- 翻页            
                local previous_button = root:AddChild(ImageButton(
                    "images/widget/chemist_skill_book_base.xml",
                    "previous_button.tex",
                    "previous_button.tex",
                    "previous_button.tex",
                    "previous_button.tex",
                    "previous_button.tex"
                ))
                previous_button:SetScale(main_scale_num,main_scale_num,main_scale_num)
                previous_button:SetPosition(-320,-190)
                -- previous_button:SetOnClick(function()

                -- end)


                local next_button = root:AddChild(ImageButton(
                    "images/widget/chemist_skill_book_base.xml",
                    "next_button.tex",
                    "next_button.tex",
                    "next_button.tex",
                    "next_button.tex",
                    "next_button.tex"
                ))
                next_button:SetScale(main_scale_num,main_scale_num,main_scale_num)
                next_button:SetPosition(320,-190)
                -- next_button:SetOnClick(function()

                -- end)
        ----------------------------------------------------------------
        ---- 显示文本
            
            local info_text = root:AddChild(Image())
            root.info_text = info_text
            info_text:SetTexture("images/widget/chemist_skill_book_base.xml","info_text.tex")
            info_text:SetPosition(-330,170)
            info_text:Show()
            info_text:SetScale(main_scale_num,main_scale_num,main_scale_num)

            --------- 玩家等级
                local level_text = root:AddChild(Text(CODEFONT,38,"XXX",{ 255/255 , 255/255 ,255/255 , 1}))
                level_text:SetPosition(-240,192)
                level_text:SetString("000")

            --------- 下一级经验
                local next_level_text = root:AddChild(Text(CODEFONT,38,"XXX",{ 255/255 , 255/255 ,255/255 , 1}))
                next_level_text:SetPosition(-240,165)
                next_level_text:SetString("0/10")
        
            --------- 剩余技能点            
                local free_points_text = root:AddChild(Text(CODEFONT,38,"XXX",{ 255/255 , 255/255 ,255/255 , 1}))
                free_points_text:SetPosition(-240,140)
                free_points_text:SetString("000")

            --------- 数据更新
                local level_data_update_fn = function()
                    local level_num = ThePlayer.replica.chemist_com_level_sys:GetCurrentLevel()
                    level_text:SetString("Lv."..tostring(level_num))

                    local next_level_exp = tostring( ThePlayer.replica.chemist_com_level_sys:GetNextLevelExp() or 0 )
                    local current_exp = tostring( ThePlayer.replica.chemist_com_level_sys:GetCurrentExp() or 0)
                    local ret_text = current_exp .. "/" .. next_level_exp
                    next_level_text:SetString(ret_text)    

                    local free_points = ThePlayer.replica.chemist_com_skill_point_sys:GetFreePoints() or 0
                    free_points_text:SetString(tostring(free_points))

                end
                level_data_update_fn()
                root.inst:DoPeriodicTask(0.5,level_data_update_fn)
                ThePlayer.replica.chemist_com_skill_point_sys:AddDataUpdateFn(level_data_update_fn)
        ----------------------------------------------------------------
        ------- 
            --     ---- 每一页 
            -- local fn = require("widgets/mms_scroll_unlock_widget_pages")
            -- -- local fn = dofile(resolvefilepath("scripts/widgets/mms_scroll_unlock_widget_pages.lua"))

            root.pages = {}
            ------------------------------------------------------------------
                local files_path = {
                    [1] = "widgets/01_chemist_skill_book_page_1",
                    [2] = "widgets/02_chemist_skill_book_page_2",
                    [3] = "widgets/02_chemist_skill_book_page_3",
                }
            ------------------------------------------------------------------
            -- 使用 dofile 加载
                -- local pages_addr = {
                --     [1] = resolvefilepath("scripts/widgets/01_chemist_skill_book_page_1.lua"),
                --     [2] = resolvefilepath("scripts/widgets/02_chemist_skill_book_page_2.lua"),
                -- }

                for i, addr in pairs(files_path) do
                    local temp_fn = dofile(resolvefilepath("scripts/"..addr..".lua"))
                    if type(temp_fn) == "function" then
                        temp_fn(root,i,main_scale_num)
                    end
                end
            ------------------------------------------------------------------
            -- 使用 require 加载
                -- for i, addr in pairs(files_path) do
                --     local temp_fn = require(addr)
                --     if type(temp_fn) == "function" then
                --         temp_fn(root,i,main_scale_num)
                --     end
                -- end
            ------------------------------------------------------------------

            for i, temp_page in pairs(root.pages) do
                temp_page:Hide()
            end
            local max_pages_num = #root.pages
            root.pages[current_dsp_page_num or 1]:Show()
            -------------- 按键切换页面
                previous_button:SetOnClick(function()
                    current_dsp_page_num = current_dsp_page_num - 1
                    if current_dsp_page_num < 1 then
                        current_dsp_page_num = max_pages_num
                    end
                    root.pages[current_dsp_page_num]:Show()
                    for i, temp_page in pairs(root.pages) do
                        if i ~= current_dsp_page_num then
                            temp_page:Hide()
                        end
                    end
                end)
                next_button:SetOnClick(function()
                    current_dsp_page_num = current_dsp_page_num + 1
                    if current_dsp_page_num > max_pages_num then
                        current_dsp_page_num = 1
                    end
                    root.pages[current_dsp_page_num]:Show()
                    for i, temp_page in pairs(root.pages) do
                        if i ~= current_dsp_page_num then
                            temp_page:Hide()
                        end
                    end
                end)

        ----------------------------------------------------------------
        ------- 声音播报
            -- ThePlayer.replica.chemist_com_skill_point_sys:AddDataUpdateFn(function()
            --     -- if root.inst.SoundEmitter == nil then
            --     --     root.inst.entity:AddSoundEmitter()
            --     -- end
            --     ThePlayer.SoundEmitter:PlaySound("dontstarve/common/together/celestial_orb/active")
            -- end)
        ----------------------------------------------------------------
        ------- 
            if TUNING.test_ui_fn then
                TUNING.test_ui_fn(root)
            end
        ----------------------------------------------------------------


    end

    function self:Chemist_Skill_Book_Close()
        if self.__chemist_skill_book_widget then
            self.__chemist_skill_book_widget:Kill()
            self.__chemist_skill_book_widget = nil
        end
        if ThePlayer then
            ThePlayer.replica.chemist_com_skill_point_sys:ClearUpdateFns()
        end
    end

end)