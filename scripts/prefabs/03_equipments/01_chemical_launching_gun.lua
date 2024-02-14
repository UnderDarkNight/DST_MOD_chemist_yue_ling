local assets =
{
    Asset("ANIM", "anim/chemist_equipment_chemical_launching_gun.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_equipment_chemical_launching_gun.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_equipment_chemical_launching_gun.xml" ),
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ 界面安装组件
    local function container_Widget_change(theContainer)
        -----------------------------------------------------------------------------------
        ----- 容器界面名 --- 要独特一点，避免冲突
        local container_widget_name = "chemist_equipment_chemical_launching_gun_widget"

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
                        Vector3(0,   32 + 4,  0),
                    },
                    animbank = "ui_cookpot_1x2",
                    animbuild = "ui_cookpot_1x2",
                    pos = Vector3(0, 15, 0),
                },
                usespecificslotsforitems = true,
                type = "hand_inv",
                excludefromcrafting = true,
            }

            ------------------------------------------------------------------------------------------
            ---- item test
                params[container_widget_name].itemtestfn =  function(container_com, item, slot)
                    if item and item:HasTag("medicine_bottle.projectile") then
                        return true
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
            inst.components.container.canbeopened = false
            -- inst.components.container.ignoresound = true

            container_Widget_change(inst.components.container)

            ---- 装备后打开界面
                inst:ListenForEvent("equipped",function(_,_table)
                    if _table and _table.owner then
                        inst:DoTaskInTime(0.1,function()
                            inst.components.container.canbeopened = true
                            inst.components.container:Open(_table.owner)
                        end)

                    end
                end)
                inst:ListenForEvent("unequipped",function(_,_table)
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

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "chemist_equipment_chemical_launching_gun", "swap_hands")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    inst:AddTag("equipped")
    owner:AddTag("chemist_equipment_chemical_launching_gun.equipped")
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_object")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    inst:RemoveTag("equipped")
    owner:RemoveTag("chemist_equipment_chemical_launching_gun.equipped")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_equipment_chemical_launching_gun")
    inst.AnimState:SetBuild("chemist_equipment_chemical_launching_gun")
    inst.AnimState:PlayAnimation("idle")

    local scale = 2
    inst.AnimState:SetScale(scale, scale, scale)
    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")
    -- inst:AddTag("rangedweapon")

    inst:AddTag("chemist_equipment_chemical_launching_gun")
    -- inst:AddTag("allow_action_on_impassable")

    MakeInventoryFloatable(inst, "med", 0.05, {0.85, 0.45, 0.85}, true, 1)


    inst.entity:SetPristine()

    add_container_before_not_ismastersim_return(inst)

    if not TheWorld.ismastersim then
        return inst
    end


    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon.hitrange = 15
    inst.components.weapon.attackrange = 15
    -- inst.components.weapon:SetOnAttack(function(inst,attacker, target)
    -- end)

    inst.components.weapon:SetOnProjectileLaunch(function(inst,attacker,target,proj)      --- 子弹发射前
        -- print("SetOnProjectileLaunch +++ ")
    end)
    inst.components.weapon:SetOnProjectileLaunched(function(inst,attacker,target,proj)    --- 子弹发射后
        if proj then
            proj:Remove()
        end
            if inst.components.container then
                local bottle_item = inst.components.container.slots[1]
                if bottle_item then
                    bottle_item:PushEvent("throw2target",{
                        target = target,
                        attacker = attacker,
                        weapon = inst,
                    })
                end
            end
    end)

    inst.components.weapon:SetProjectile(nil)
	inst.components.weapon:SetProjectileOffset(1)

    inst.components.weapon:SetProjectile("chemist_projectile_firenettles_bullet")   --- 弹药的prefab

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- inst.components.inventoryitem:ChangeImageName("chemist_equipment_chemical_launching_gun")
    inst.components.inventoryitem.imagename = "chemist_equipment_chemical_launching_gun"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_equipment_chemical_launching_gun.xml"
    inst.components.inventoryitem:SetSinks(true)

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    -- inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT
    inst.components.equippable.retrictedtag = "chemist_yue_ling"    --- 限制穿戴的玩家，必须有这个tag才能穿


    MakeHauntableLaunch(inst)

    ---------------------------------------------------------------------
    --- in_gun
        inst:ListenForEvent("itemget",function(_,_table)
            if not (_table and _table.item) then
                return
            end
            local item = _table.item
            item:AddTag("in_gun")
        end)
        inst:ListenForEvent("itemlose",function(_,_table)
            if not (_table and _table.prev_item) then
                return
            end
            local item = _table.prev_item
            item:AddTag("in_gun")
        end)
    ---------------------------------------------------------------------
    return inst
end

return Prefab("chemist_equipment_chemical_launching_gun", fn, assets)
