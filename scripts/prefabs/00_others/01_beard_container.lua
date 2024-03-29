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
            -- inst.components.container.stay_open_on_hide = true

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
    inst:AddTag("bramble_resistant")

    inst.entity:SetPristine()
    
    add_container_before_not_ismastersim_return(inst)

    if not TheWorld.ismastersim then
        return inst
    end


    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem.keepondeath = true --- 死亡不掉落

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BEARD
    inst.components.equippable:SetPreventUnequipping(true)  --- 死亡不掉落

    inst.components.equippable:SetOnEquip(function(_,owner)
        if owner and owner.prefab == "chemist_yue_ling" then
            inst.components.container:Open(owner)
        else
            inst:Remove()
        end
        -- inst.components.container:Close(owner)
    end)
    inst.components.equippable:SetOnUnequip(function(_,owner)
        if owner and owner.prefab == "chemist_yue_ling" then
            inst.components.container:Close(owner)
        else
            inst:Remove()
        end
    end)
    inst.components.equippable.retrictedtag = "chemist_yue_ling"

    -----------------------------------------------------------------------
    ---- 保鲜

    -----------------------------------------------------------------------
    ---
        local function DropEverythingAndRemove()
            if inst:IsValid() then
                inst.components.container:Close()
                inst.components.container:DropEverything()
                inst:Remove()
            end
        end
    -----------------------------------------------------------------------
    ---- 被其他MOD打掉落的时候处理
        inst:ListenForEvent("unequipped",function(_,_table)
            -- inst.components.container:DropEverything()
            -- inst:Remove()
            DropEverythingAndRemove()
        end)
    -----------------------------------------------------------------------
    ---- 换角色的时候移除
        inst:ListenForEvent("equipped",function(_,_table)            
            if _table and _table.owner and _table.owner.prefab == "chemist_yue_ling" then
                _table.owner:ListenForEvent("ms_playerreroll",DropEverythingAndRemove)
                _table.owner:ListenForEvent("death",function()
                    -- inst.components.container:Close()
                    DropEverythingAndRemove()
                end)
            else
                inst:Remove()
            end
        end)
    -----------------------------------------------------------------------
    ----
        inst:ListenForEvent("on_landed",DropEverythingAndRemove)

    -----------------------------------------------------------------------
    MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab("chemist_other_beard_container", fn3, assets)
