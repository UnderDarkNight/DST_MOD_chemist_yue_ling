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


return function (book_root,page_num,main_scale_num)
    

    local page = book_root:AddChild(Widget())
    book_root.pages = book_root.pages or {}
    book_root.pages[page_num] = page
    ------------------------------------------------------------------------------------------------------------------------
    ---------- 基础数据
        local page_atlas = "images/widget/chemist_skill_book_revival_medicine.xml"
    ------------------------------------------------------------------------------------------------------------------------
    ---------- 标题
        local title = page:AddChild(Image())
        title:SetTexture(page_atlas,"title.tex")
        title:SetPosition(0,220)
        title:Show()
        title:SetScale(main_scale_num,main_scale_num,main_scale_num)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- 说明文本
        local info_text = page:AddChild(Image())
        info_text:SetTexture(page_atlas,"info_text.tex")
        info_text:SetPosition(150,70)
        info_text:Show()
        info_text:SetScale(main_scale_num,main_scale_num,main_scale_num)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- 图标框背景
        local icon_bg = page:AddChild(Image())
        icon_bg:SetTexture(page_atlas,"icon_bg.tex")
        icon_bg:SetPosition(-220,50)
        icon_bg:Show()
        icon_bg:SetScale(main_scale_num,main_scale_num,main_scale_num)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- 图标框
        local icon = icon_bg:AddChild(Image())
        icon:SetTexture(page_atlas,"icon_lv_0.tex")
        icon:SetPosition(0,0)
        icon:Show()
        -- icon:SetScale(main_scale_num,main_scale_num,main_scale_num)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- 药水等级
        local text_lv = page:AddChild(Image())
        text_lv:SetTexture(page_atlas,"text_lv_0.tex")
        text_lv:SetPosition(-220,-40)
        text_lv:Show()
        text_lv:SetScale(main_scale_num,main_scale_num,main_scale_num)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- +1 按钮
        local button_lv_up = page:AddChild(ImageButton(
            page_atlas,
            "button_lv_up.tex",
            "button_lv_up.tex",
            "button_lv_up.tex",
            "button_lv_up.tex",
            "button_lv_up.tex"
        ))
        button_lv_up:SetScale(main_scale_num,main_scale_num,main_scale_num)
        button_lv_up:SetPosition(-250,-90)
        button_lv_up:SetOnClick(function()
            ThePlayer.replica.chemist_com_skill_point_sys:ButtonClick("revival_medicine.button_lv_up")
        end)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- +MAX 按钮
        local button_lv_max = page:AddChild(ImageButton(
            page_atlas,
            "button_lv_max.tex",
            "button_lv_max.tex",
            "button_lv_max.tex",
            "button_lv_max.tex",
            "button_lv_max.tex"
        ))
        button_lv_max:SetScale(main_scale_num,main_scale_num,main_scale_num)
        button_lv_max:SetPosition(-190,-90)
        button_lv_max:SetOnClick(function()
            ThePlayer.replica.chemist_com_skill_point_sys:ButtonClick("revival_medicine.button_lv_max")
        end)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- 双倍框
        local double_bg = page:AddChild(Image())
        double_bg:SetTexture(page_atlas,"double_bg.tex")
        double_bg:SetPosition(120,-100)
        double_bg:Show()
        double_bg:SetScale(main_scale_num,main_scale_num,main_scale_num)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- 双倍框标题
        local double_info_lv = page:AddChild(Image())
        double_info_lv:SetTexture(page_atlas,"double_info_lv_0.tex")
        double_info_lv:SetPosition(120,-80)
        double_info_lv:Show()
        double_info_lv:SetScale(main_scale_num,main_scale_num,main_scale_num)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- 百分比数字
        local double_lv = page:AddChild(Image())
        double_lv:SetTexture(page_atlas,"double_lv_0.tex")
        double_lv:SetPosition(40,-120)
        double_lv:Show()
        double_lv:SetScale(main_scale_num,main_scale_num,main_scale_num)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- double +1 按钮
        local button_double_lv_up = page:AddChild(ImageButton(
            page_atlas,
            "button_double_lv_up.tex",
            "button_double_lv_up.tex",
            "button_double_lv_up.tex",
            "button_double_lv_up.tex",
            "button_double_lv_up.tex"
        ))
        button_double_lv_up:SetScale(main_scale_num,main_scale_num,main_scale_num)
        button_double_lv_up:SetPosition(120,-120)
        button_double_lv_up:SetOnClick(function()
            ThePlayer.replica.chemist_com_skill_point_sys:ButtonClick("revival_medicine.button_double_lv_up")
        end)
    ------------------------------------------------------------------------------------------------------------------------
    ---------- double +MAX 按钮
        local button_double_lv_max = page:AddChild(ImageButton(
            page_atlas,
            "button_double_lv_max.tex",
            "button_double_lv_max.tex",
            "button_double_lv_max.tex",
            "button_double_lv_max.tex",
            "button_double_lv_max.tex"
        ))
        button_double_lv_max:SetScale(main_scale_num,main_scale_num,main_scale_num)
        button_double_lv_max:SetPosition(200,-120)
        button_double_lv_max:SetOnClick(function()
            ThePlayer.replica.chemist_com_skill_point_sys:ButtonClick("revival_medicine.button_double_lv_max")
        end)

    ------------------------------------------------------------------------------------------------------------------------
    ----- 数据初始化
        local data_init_fn = function()
            local item_level = tostring( ThePlayer.replica.chemist_com_skill_point_sys:Get("revival_medicine.item_level") or 0 )
            local double_level = tostring( ThePlayer.replica.chemist_com_skill_point_sys:Get("revival_medicine.double_level") or 0 )
            
            icon:SetTexture(page_atlas,"icon_lv_"..item_level..".tex")
            text_lv:SetTexture(page_atlas,"text_lv_"..item_level..".tex")

            double_info_lv:SetTexture(page_atlas,"double_info_lv_"..double_level..".tex")
            double_lv:SetTexture(page_atlas,"double_lv_"..double_level..".tex")

        end

        data_init_fn()
        ThePlayer.replica.chemist_com_skill_point_sys:AddDataUpdateFn(data_init_fn)
    ------------------------------------------------------------------------------------------------------------------------
 




end