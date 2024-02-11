----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    药材袋

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_item_herbal_bag.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_herbal_bag.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_herbal_bag.xml" ),
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------
    local cooking = require("cooking")
    local function item_test(item)
        ----- 大厨锅能做出来的东西才能放进去

        local food_base_prefab = item.nameoverride or item.prefab

        local crash_flag,ret = pcall(function()

            local recipe = cooking.GetRecipe("portablecookpot", food_base_prefab)   --- 获取大厨锅 的配方
            if recipe then
                return true
            end
            return false

        end)
            
        if crash_flag then
            return ret
        else
            return false
        end
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ 界面安装组件
    local function container_Widget_change(theContainer)
        -----------------------------------------------------------------------------------
        ----- 容器界面名 --- 要独特一点，避免冲突
        local container_widget_name = "chemist_item_herbal_bag_widget"

        -----------------------------------------------------------------------------------
        ----- 检查和注册新的容器界面
        local all_container_widgets = require("containers")
        local params = all_container_widgets.params
        if params[container_widget_name] == nil then
            params[container_widget_name] = {
                widget =
                {
                    slotpos = {},
                    animbank = "ui_chest_3x3",
                    animbuild = "ui_chest_3x3",
                    pos = Vector3(400, 200, 0),
                    side_align_tip = 160,
                },
                type = "chest", 
            }

            for y = 2, 0, -1 do
                for x = 0, 2 do
                    table.insert(params[container_widget_name].widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
                end
            end
            ------------------------------------------------------------------------------------------
            ---- item test
                params[container_widget_name].itemtestfn =  function(container_com, item, slot)
                    if item and item.prefab then
                        return item_test(item)
                    end
                    return false
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
            inst.components.container.canbeopened = false


            inst:ListenForEvent("into_chemist_other_beard_container",function()
                inst.components.container.canbeopened = true                
            end)
            inst:ListenForEvent("leave_chemist_other_beard_container",function()
                inst.components.container:Close()
                inst.components.container.canbeopened = false
                
            end)

        else

            inst.OnEntityReplicated = function(inst)
                container_Widget_change(inst.replica.container)
            end

        end

    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_item_herbal_bag")
    inst.AnimState:SetBuild("chemist_item_herbal_bag")
    inst.AnimState:PlayAnimation("idle")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("chemist_item_herbal_bag")
    inst:AddTag("chemist_tag.can_go_into_beard_container")

    -- local swap_data = {sym_build = "swap_cane"}
    MakeInventoryFloatable(inst, "med", 0.05, {0.85, 0.45, 0.85}, true, 1)


    inst.entity:SetPristine()

    add_container_before_not_ismastersim_return(inst)

    ------------------------------------------------------------------------------------------------------------
    --- 保鲜
        if TheWorld.ismastersim then

            inst:AddComponent("preserver")  --- 官方保鲜/返鲜组件
            -- inst.components.preserver.perish_rate_multiplier = function(inst,item)
            --     --- 新鲜值 降低倍数
            --     return 2
            -- end
            inst.components.preserver.perish_rate_multiplier = 0.5 -- 腐烂速度减半
        end
    ------------------------------------------------------------------------------------------------------------



    if not TheWorld.ismastersim then
        return inst
    end




    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- inst.components.inventoryitem:ChangeImageName("chemist_equipment_chemical_launching_gun")
    inst.components.inventoryitem.imagename = "chemist_item_herbal_bag"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_item_herbal_bag.xml"
    
    inst.components.inventoryitem.cangoincontainer = true
    



    MakeHauntableLaunch(inst)
    -------------------------------------------------------------------
    --- 落水影子
        local function shadow_init(inst)
            if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
                -- inst.AnimState:Hide("SHADOW")
                inst.AnimState:PlayAnimation("water")
            else                                
                -- inst.AnimState:Show("SHADOW")
                inst.AnimState:PlayAnimation("idle")
            end
        end
        inst:ListenForEvent("on_landed",shadow_init)
        shadow_init(inst)
    -------------------------------------------------------------------
    ---- 积雪监听执行
        local function snow_over_init(inst)
            if TheWorld.state.issnowcovered then
                inst.AnimState:Show("SNOW")
            else
                inst.AnimState:Hide("SNOW")
            end
        end
        snow_over_init(inst)
        inst:WatchWorldState("issnowcovered", snow_over_init)
    -------------------------------------------------------------------
    return inst
end

return Prefab("chemist_item_herbal_bag", fn, assets)