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



AddClassPostConstruct("screens/playerhud",function(self)
    local hud = self

    function self:Chemist_Skill_Book_Open()
        if self.__chemist_skill_book_widget then
            self.__chemist_skill_book_widget:Kill()
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
                local level_text = root:AddChild(Text(CODEFONT,40,"XXX",{ 255/255 , 255/255 ,255/255 , 1}))
                level_text:SetPosition(-240,182)
                -- level_text:SetString("000")
                local level_num = ThePlayer.replica.chemist_com_level_sys:GetCurrentLevel()
                level_text:SetString(tostring(level_num))
            
            --------- 剩余技能点            
                local free_points_text = root:AddChild(Text(CODEFONT,40,"XXX",{ 255/255 , 255/255 ,255/255 , 1}))
                free_points_text:SetPosition(-240,150)
                -- free_points_text:SetString("000")
                local free_points = ThePlayer.replica.chemist_com_skill_point_sys.free_points or 0
                free_points_text:SetString(tostring(free_points))

            ---- 添加刷新函数
                ThePlayer.replica.chemist_com_skill_point_sys:AddDataUpdateFn(function()
                    local free_points = ThePlayer.replica.chemist_com_skill_point_sys:GetFreePoints() or 0
                    free_points_text:SetString(tostring(free_points))
                end)
        ----------------------------------------------------------------
        ------- 
            --     ---- 每一页 
            -- local fn = require("widgets/mms_scroll_unlock_widget_pages")
            -- -- local fn = dofile(resolvefilepath("scripts/widgets/mms_scroll_unlock_widget_pages.lua"))
            root.pages = {}
            
            local pages_addr = {
                [1] = resolvefilepath("scripts/widgets/01_chemist_skill_book_page_1.lua"),
            }
            for i, addr in pairs(pages_addr) do
                local temp_fn = dofile(addr)
                if type(temp_fn) == "function" then
                    temp_fn(root,i,main_scale_num)
                end
            end
        ----------------------------------------------------------------
        ------- 
            -- if TUNING.test_ui_fn then
            --     TUNING.test_ui_fn(root)
            -- end
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