local assets =
{
    -- Asset("ANIM", "anim/backpack.zip"),
    -- Asset("ANIM", "anim/swap_krampus_sack.zip"),
    Asset("ANIM", "anim/chemist_other_beard_container.zip"),
    -- Asset( "IMAGE", "images/widget/chemist_other_beard_container_widget_bg.tex" ), 
    -- Asset( "ATLAS", "images/widget/chemist_other_beard_container_widget_bg.xml" ),
}

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 安装容器界面
    local function container_Widget_change(theContainer)
        -----------------------------------------------------------------------------------
        ----- 容器界面名 --- 要独特一点，避免冲突
        local container_widget_name = "chemist_other_beard_container_widget"

        -----------------------------------------------------------------------------------
        ----- 检查和注册新的容器界面
        local all_container_widgets = require("containers")
        local params = all_container_widgets.params
        if params[container_widget_name] == nil then
            params[container_widget_name] = {
                widget =
                {
                    slotpos =
                    {
                        Vector3(-(64 + 12)/2, -5, 0),
                        Vector3( (64 + 12)/2, -5, 0),
                    },
                    -- slotbg =
                    -- {
                    --     { image = "chemist_other_beard_container_widget_bg.tex" ,atlas = "images/widget/chemist_other_beard_container_widget_bg.xml"},
                    --     { image = "chemist_other_beard_container_widget_bg.tex" ,atlas = "images/widget/chemist_other_beard_container_widget_bg.xml"},

                    -- },
                    animbank = "chemist_other_beard_container",
                    animbuild = "chemist_other_beard_container",
                    pos = Vector3(-82, 89, 0),
                    bottom_align_tip = -100,
                },
                type = "side_inv_behind",
                acceptsstacks = true,
                lowpriorityselection = true,
            }
            ------------------------------------------------------------------------------------------
            ---- item test
                params[container_widget_name].itemtestfn =  function(container_com, item, slot)
                    -- return item and item.prefab == "chemist_yue_ling_equipment_cape"
                    if item and item:HasTag("chemist_tag.can_go_into_beard_container") then
                        return true
                    end
                    return false
                end
            ------------------------------------------------------------------------------------------

            ------------------------------------------------------------------------------------------
        end
        
        theContainer:WidgetSetup(container_widget_name)
        ------------------------------------------------------------------------
    end

    local function add_container_before_not_ismastersim_return(inst)
        -------------------------------------------------------------------------------------------------
        ------ 添加背包container组件    --- 必须在 SetPristine 之后，
        if TheWorld.ismastersim then
            inst:AddComponent("container")
            -- inst.components.container.openlimit = 1  ---- 限制1个人打开
            container_Widget_change(inst.components.container)
            -- inst.components.container:WidgetSetup("beard_sack_1")


            -------------------------------------------------------------------------------------------------
            --- 往放进去的东西发送事件
                inst:ListenForEvent("itemget", function(_,_table)
                    if _table and _table.item then
                        _table.item:PushEvent("into_chemist_other_beard_container")
                    end
                end)
                inst:ListenForEvent("itemlose", function(_,_table)
                    if _table and _table.prev_item then
                        _table.prev_item:PushEvent("leave_chemist_other_beard_container")
                    end
                end)
            -------------------------------------------------------------------------------------------------


        else
            inst.OnEntityReplicated = function(inst)
                container_Widget_change(inst.replica.container)
                -- inst.replica.container:WidgetSetup("beard_sack_1")
            end
        end
        -------------------------------------------------------------------------------------------------
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function fn3()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("backpack1")
    inst.AnimState:SetBuild("swap_krampus_sack")
    inst.AnimState:PlayAnimation("anim")
    
    inst:AddTag("hana_beard_container")

    inst.entity:SetPristine()
    
    add_container_before_not_ismastersim_return(inst)

    if not TheWorld.ismastersim then
        return inst
    end


    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = false

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BEARD
    inst.components.equippable:SetPreventUnequipping(true)
    inst.components.equippable:SetOnEquip(function(_,owner)
        inst.components.container:Open(owner)
        -- inst.components.container:Close(owner)
    end)
    inst.components.equippable:SetOnUnequip(function(_,owner)
        inst.components.container:Close(owner)
    end)
    -- inst.components.equippable.retrictedtag = "chemist_yue_ling"

    -----------------------------------------------------------------------
    ---- 保鲜

    -----------------------------------------------------------------------
    ---- 被其他MOD打掉落的时候处理
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner then
                inst:DoTaskInTime(0,function()
                    _table.owner.components.inventory:Equip(inst)
                end)
            end
        end)
    -----------------------------------------------------------------------
    ---- 换角色的时候移除
        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner then
                _table.owner:ListenForEvent("ms_playerreroll",function()
                    if inst:IsValid() then
                        inst.components.container:DropEverything()
                        inst:Remove()
                    end
                end)
            end
        end)
    -----------------------------------------------------------------------
        -- inst:ListenForEvent("itemget",function(_,_table)
        --     if _table and _table.item then
        --         local owner = inst.components.inventoryitem:GetGrandOwner()
        --         _table.item.owner = owner
        --         _table.item.container_inst = inst
        --     end
        -- end)
    -----------------------------------------------------------------------
        -- inst:ListenForEvent("open_widget",function()
        --     if inst.components.inventoryitem:GetGrandOwner() then
        --         inst.components.container:Open(inst.components.inventoryitem:GetGrandOwner())
        --     end
        -- end)
        -- inst:ListenForEvent("item_equiped",function()
        --     inst:PushEvent("open_widget")
        -- end)
    -----------------------------------------------------------------------
    MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab("chemist_other_beard_container", fn3, assets)
