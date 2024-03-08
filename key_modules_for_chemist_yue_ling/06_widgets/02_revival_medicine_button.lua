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
        if inst and ThePlayer and inst == ThePlayer and inst.HUD then
            ThePlayer:ListenForEvent("chemist_revival_medicine_buttons",function(_,_table)
                _table = _table or {}
                ThePlayer.HUD:revival_medicine_button_open(_table)
            end)
        end
    end)
end)


AddClassPostConstruct("screens/playerhud",function(self)
    local hud = self

    function self:revival_medicine_button_open(cmd_table)
        ----------------------------------------------------------------
            local level = cmd_table.level or 1
            local x = cmd_table.x or 0
            local y = cmd_table.y or 0
            local info_only = cmd_table.info_only or false
            local scale = cmd_table.scale or 1
            local alpha = cmd_table.alpha or cmd_table.a
        ----------------------------------------------------------------
        if self.__revival_medicine_button then
            self.__revival_medicine_button:Kill()
            self.__revival_medicine_button = nil
        end
        ----------------------------------------------------------------
            local main_scale_num = 0.6*scale
        ----------------------------------------------------------------

            local root = self:AddChild(Screen())
            self.__revival_medicine_button = root

        ----------------------------------------------------------------
        -------- 设置锚点
            root:SetHAnchor(0) -- 设置原点x坐标位置，0、1、2分别对应屏幕中、左、右
            root:SetVAnchor(0) -- 设置原点y坐标位置，0、1、2分别对应屏幕中、上、下
            root:SetPosition(0,0)
            root:MoveToBack()
            root:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)   --- 缩放模式
        ----------------------------------------------------------------
        ------- 按钮
            local tex_name = "lv_"..tostring(level)..".tex"
            local theButton = root:AddChild(ImageButton(
                    "images/widget/chemist_revival_medicine_buttons.xml",
                    tex_name,
                    tex_name,
                    tex_name,
                    tex_name,
                    tex_name
                ))
                theButton:SetScale(main_scale_num,main_scale_num,main_scale_num)
                theButton:SetPosition(x or 300,y or 0)
                theButton:SetOnClick(function()
                    -- chemist_revival_medicine_buttons_click
                    if ThePlayer.replica.chemist_com_rpc_event then
                        ThePlayer.replica.chemist_com_rpc_event:PushEvent("chemist_revival_medicine_buttons_click")
                    end
                    hud:revival_medicine_button_close()
                end)
                if alpha then
                    theButton:SetFadeAlpha(alpha)
                end
                if info_only then
                    theButton:Disable()
                    theButton:OnDisable()
                end
        ----------------------------------------------------------------
        ----
            if info_only then
                root:Disable()
                root:SetClickable(false)
            end

        ----------------------------------------------------------------

    end
    function self:revival_medicine_button_close()
        if self.__revival_medicine_button then
            self.__revival_medicine_button:Kill()
            self.__revival_medicine_button = nil
        end
    end


end)