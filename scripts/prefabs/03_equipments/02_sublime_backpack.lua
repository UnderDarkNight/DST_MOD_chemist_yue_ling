----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    次元背包

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_equipment_sublime_backpack.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_equipment_sublime_backpack.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_equipment_sublime_backpack.xml" ),
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ 界面安装组件
    local function container_Widget_change(theContainer)
        -----------------------------------------------------------------------------------
        ----- 容器界面名 --- 要独特一点，避免冲突
        local container_widget_name = "chemist_equipment_sublime_backpack_widget"

        -----------------------------------------------------------------------------------
        ----- 检查和注册新的容器界面
        local all_container_widgets = require("containers")
        local params = all_container_widgets.params
        if params[container_widget_name] == nil then
            params[container_widget_name] = {
                widget =
                {
                    slotpos = {},
                    animbank = "ui_krampusbag_2x8",
                    animbuild = "ui_krampusbag_2x8",
                    --pos = Vector3(-5, -120, 0),
                    pos = Vector3(-5, -130, 0),
                },
                issidewidget = true,
                type = "pack",
                openlimit = 1,       
            }

            for y = 0, 6 do
                table.insert(params[container_widget_name].widget.slotpos, Vector3(-162, -75 * y + 240, 0))
                table.insert(params[container_widget_name].widget.slotpos, Vector3(-162 + 75, -75 * y + 240, 0))
            end
            ------------------------------------------------------------------------------------------
            ---- item test
                params[container_widget_name].itemtestfn =  function(container_com, item, slot)
                    return true
                end
            ------------------------------------------------------------------------------------------
        end
        
        theContainer:WidgetSetup(container_widget_name)

        ------------------------
        --- 声音关闭
        if theContainer.SetSkipOpenSnd then
            theContainer:SetSkipOpenSnd(true)   ---- 打开时候的声音
            theContainer:SetSkipCloseSnd(true)  ---- 关闭时候的声音
        end
        ------------------------------------------------------------------------
    end


    local function add_container_before_not_ismastersim_return(inst)
    -------------------------------------------------------------------------------------------------
    ------ 添加背包container组件    --- 必须在 SetPristine 之后，
    -- -- local container_WidgetSetup = "wobysmall"


        if TheWorld.ismastersim then

            inst:AddComponent("container")
            inst.components.container.openlimit = 1  ---- 限制1个人打开
            container_Widget_change(inst.components.container)    

        else

            inst.OnEntityReplicated = function(inst)
                container_Widget_change(inst.replica.container)
            end

        end

    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


    local function onequip(inst, owner)


        owner.AnimState:OverrideSymbol("backpack", "chemist_equipment_sublime_backpack", "swap_body")
        owner.AnimState:OverrideSymbol("swap_body", "chemist_equipment_sublime_backpack", "swap_body")    
        inst.components.container:Open(owner)
    end

    local function onunequip(inst, owner)
        owner.AnimState:ClearOverrideSymbol("swap_body")
        owner.AnimState:ClearOverrideSymbol("backpack")
        inst.components.container:Close(owner)
    end

    local function onequiptomodel(inst, owner)
        inst.components.container:Close(owner)
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_equipment_sublime_backpack")
    inst.AnimState:SetBuild("chemist_equipment_sublime_backpack")
    inst.AnimState:PlayAnimation("idle")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("chemist_equipment_sublime_backpack")
    inst:AddTag("backpack")


    -- local swap_data = {sym_build = "swap_cane"}
    MakeInventoryFloatable(inst, "med", 0.05, {0.85, 0.45, 0.85}, true, 1)


    inst.entity:SetPristine()

    add_container_before_not_ismastersim_return(inst)


    ------------------------------------------------------------------------------------------------------------
    --- 计数器
        if TheWorld.ismastersim then
            inst:AddComponent("chemist_com_database")
        end
    ------------------------------------------------------------------------------------------------------------
    ---  物品接受组件
        if TheWorld.ismastersim then

            inst:AddComponent("chemist_com_acceptable")
            inst.components.chemist_com_acceptable:SetOnAcceptFn(function(inst,item,doer)
                local on_accept_fns = {
                    ["bluegem"] = function() --- 最大接受10个
                        local max_num = 10
                        local current_num = inst.components.chemist_com_database:Add("bluegem",0)
                        local item_num = item.components.stackable.stacksize
                        
                        if current_num >= max_num then
                            return false
                        end

                        item.components.stackable:Get():Remove()
                        inst.components.chemist_com_database:Add("bluegem",1)

                        inst:PushEvent("refresh.preserver")
                        return true
                    end,
                    ["purplegem"] = function() --- 最大接受50个
                        local max_num = 50
                        local current_num = inst.components.chemist_com_database:Add("purplegem",0)
                        local item_num = item.components.stackable.stacksize
                        
                        if current_num >= max_num then
                            return false
                        end

                        local cost_num = max_num - current_num

                        if item_num > cost_num then
                            item.components.stackable:Get(cost_num):Remove()
                            inst.components.chemist_com_database:Set("purplegem",max_num)
                        else
                            item:Remove()
                            inst.components.chemist_com_database:Add("purplegem",item_num)
                        end

                        -- item.components.stackable:Get():Remove()
                        -- inst.components.chemist_com_database:Add("purplegem",1)

                        inst:PushEvent("refresh.dapperness")
                        return true
                    end,
                }

                if item and item.prefab and on_accept_fns[item.prefab] then
                    return on_accept_fns[item.prefab]()
                end
                return false
            end)
        end
        inst:DoTaskInTime(0,function()
            local chemist_com_acceptable = inst.replica.chemist_com_acceptable or inst.replica._.chemist_com_acceptable
            if chemist_com_acceptable then
                chemist_com_acceptable:SetTestFn(function(inst,item,doer)

                    local test_fns = {
                        ["bluegem"] = function()
                            if inst:HasTag("bluegem.max") then
                                return false
                            else
                                return true
                            end
                        end,
                        ["purplegem"] = function()
                            if inst:HasTag("purplegem.max") then
                                return false
                            else
                                return true
                            end
                        end,
                    }

                    if item and item.prefab and  test_fns[item.prefab] then
                        return test_fns[item.prefab]()
                    end
                    return false                    
                end)
                chemist_com_acceptable:SetText(inst.prefab,STRINGS.ACTIONS.UPGRADE.GENERIC)
                chemist_com_acceptable:SetSGAction("dolongaction")
            end
        end)

    ------------------------------------------------------------------------------------------------------------
    --- 保鲜
        if TheWorld.ismastersim then

            inst:AddComponent("preserver")  --- 官方保鲜/返鲜组件
            -- inst.components.preserver.perish_rate_multiplier = function(inst,item)
            --     --- 新鲜值 降低倍数
            --     -- 初始自带保鲜，添加1颗蓝宝石增加0.1的返鲜速度，最高返鲜速度为2
            --     -- 1-2
            --     return 2
            -- end
            inst:ListenForEvent("refresh.preserver",function()
                local current_num = inst.components.chemist_com_database:Add("bluegem",0)
                -- print("info 蓝宝石个数",current_num)
                local base_perish_rate_multiplier = 1
                local ret = base_perish_rate_multiplier + (current_num * 0.1)
                if ret > 2 then
                    ret = 2
                end

                if ret >= 2 then
                    inst:AddTag("bluegem.max")
                end
                inst.components.preserver.perish_rate_multiplier = -1 * ret
            end)

            inst:DoTaskInTime(0,function() --- 初始化
                inst:PushEvent("refresh.preserver")
            end)

        end
    ------------------------------------------------------------------------------------------------------------
    --- 动态回San
        if TheWorld.ismastersim then
            inst:DoTaskInTime(0,function()

                            -- 初始自带回san效果，三秒回复1点，添加紫宝石提升回san效果，每添加一颗提升0.5，最高每三秒回复6点（十颗紫宝石+初始1点，合计6点）
                            -- 消耗紫色宝石：50
                            -- 每分钟： 20 -> 120
                            --- y = 2*x + 20
                
                            inst:ListenForEvent("refresh.dapperness",function()
                                
                                local purplegem_num = inst.components.chemist_com_database:Add("purplegem",0)
                                if purplegem_num >= 50 then
                                    purplegem_num = 50
                                    inst:AddTag("purplegem.max")
                                end
                                -- print("info 当前紫色宝石数量",purplegem_num)

                                local ret = 2*purplegem_num + 20
                                inst.components.equippable.GetDapperness = function()
                                    return ret/60
                                end

                            end)

                            inst:PushEvent("refresh.dapperness") --- 初始化的时候

            end)
        end
    ------------------------------------------------------------------------------------------------------------




    if not TheWorld.ismastersim then
        return inst
    end




    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- inst.components.inventoryitem:ChangeImageName("chemist_equipment_chemical_launching_gun")
    inst.components.inventoryitem.imagename = "chemist_equipment_sublime_backpack"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_equipment_sublime_backpack.xml"
    
    inst.components.inventoryitem.cangoincontainer = true

    inst:AddComponent("equippable")

    inst.components.equippable.equipslot = TUNING["chemist_yue_ling_er.equip_slot"]:GetBackpackType() or EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable:SetOnEquipToModel(onequiptomodel)
    inst.components.equippable.retrictedtag = "chemist_yue_ling"    --- 限制穿戴的玩家，必须有这个tag才能穿

    -- inst.components.equippable.GetDapperness = function()
    --     return 1
    -- end


    MakeHauntableLaunch(inst)
    -------------------------------------------------------------------
    --- 落水影子
        local function shadow_init(inst)
            if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
                inst.AnimState:Hide("SHADOW")
                -- inst.AnimState:PlayAnimation("water")
            else                                
                inst.AnimState:Show("SHADOW")
                -- inst.AnimState:PlayAnimation("idle")
            end
        end
        inst:ListenForEvent("on_landed",shadow_init)
        shadow_init(inst)
    -------------------------------------------------------------------
    -------------------------------------------------------------------
    return inst
end

return Prefab("chemist_equipment_sublime_backpack", fn, assets)
