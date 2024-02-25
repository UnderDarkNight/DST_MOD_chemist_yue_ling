------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    火荨麻 药剂瓶

    medicine bottle

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_item_firenettles_medicine_bottle.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_firenettles_medicine_bottle.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_firenettles_medicine_bottle.xml" ),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_item_firenettles_medicine_bottle")
    inst.AnimState:SetBuild("chemist_item_firenettles_medicine_bottle")
    inst.AnimState:PlayAnimation("idle")
    
    -- inst.pickupsound = "wood"
    inst:AddTag("medicine_bottle")
    inst:AddTag("medicine_bottle.projectile")

    MakeInventoryFloatable(inst, "med", 0.1, 0.75)

    inst.entity:SetPristine()
    --------------------------------------------------------------------------------------------------------------------------------------
    --- 右键使用
        if TheWorld.ismastersim then
            inst:AddComponent("chemist_com_workable")
            inst.components.chemist_com_workable:SetActiveFn(function(inst, player)

                local weapon = player.components.combat:GetWeapon()
                if weapon then
                    -- weapon.components.container:GiveItem(inst)
                    local old_item = weapon.components.container:GetItemInSlot(1)
                    if old_item == nil then
                        ---- 如果目标位置没有物品
                        player.components.inventory:DropItem(inst,true)
                        weapon.components.container:GiveItem(inst)
                    elseif old_item.prefab == inst.prefab then
                        ---- 如果目标位置已经有物品
                        local old_item_num = old_item.components.stackable.stacksize
                        -- local new_item_num = inst.components.stackable.stacksize
                        local max_num = inst.components.stackable.maxsize

                        local target_num = max_num - old_item_num
                        if target_num > 0 then
                            weapon.components.container:GiveItem(inst.components.stackable:Get(target_num))
                        end

                    else
                        --- 换掉原来的
                        player.components.inventory:DropItem(old_item,true)
                        weapon.components.container:GiveItem(inst)
                        player.components.inventory:GiveItem(old_item)

                    end
                end

                return true
            end)
        end
        inst:DoTaskInTime(0,function()
            local replica_com = inst.replica.chemist_com_workable or inst.replica._.chemist_com_workable
            if replica_com then

                replica_com:SetText(inst.prefab,STRINGS.ACTIONS.CHANGE_TACKLE.AMMO)
                replica_com:SetTestFn(function(inst, player,right_click)
                    if inst:HasTag("in_gun") then
                        return false
                    end
                    local weapon = player.replica.combat:GetWeapon()
                    if inst.replica.inventoryitem:IsGrandOwner(player) 
                        and weapon and weapon:HasTag("chemist_equipment_chemical_launching_gun")
                            then
                        return true
                    end
                    return false
                end)

                replica_com:SetSGAction("give")
                
            end
        end)
    --------------------------------------------------------------------------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end




    MakeHauntableLaunchAndIgnite(inst)

    ---------------------

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- inst.components.inventoryitem:ChangeImageName("chemist_equipment_chemical_launching_gun")
    inst.components.inventoryitem.imagename = "chemist_item_firenettles_medicine_bottle"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_item_firenettles_medicine_bottle.xml"

    inst:AddComponent("stackable")
    -- inst.components.stackable.maxsize = 20

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
    --- 

        inst:ListenForEvent("throw2target",function(_,_table)
            -- _table = {
            --     pt = Vector3(0,0,0),
            --     target = target,
            --     attacker = attacker,
            --     weapon = weapon,
            -- }
            local attacker = _table.attacker
            local target = _table.target
            local weapon = _table.weapon


            local x,y,z = attacker.Transform:GetWorldPosition()
            local bullet = SpawnPrefab("chemist_projectile_firenettles_bullet")
            bullet.Transform:SetPosition(x, 1.5, z)
            bullet.components.projectile:Throw(bullet,target,attacker)
            bullet.components.projectile:SetOnHitFn(function()
                
                if target and target.components.combat and target.components.health then
                    target.components.combat:GetAttacked(attacker,100)
    
                    for i = 1, 10, 1 do
                        target:DoTaskInTime(i,function()
                            if not target.components.health:IsDead() then
                                target.components.health:DoDelta(-10)
                            end                        
                        end)
                    end
                    
                end

                SpawnPrefab("chemist_fx_explode"):PushEvent("Set",{
                    target = target,
                    color = Vector3(255,0,0)
                })
    
                bullet:Remove()
            end)
            -------------------------------------------------------------------
            ---- 近距离不显示
                bullet:Hide()
                local hide_dissq = 1.3 * 1.3
                bullet.__dis_dsp_task = bullet:DoPeriodicTask(FRAMES,function()
                    
                        if attacker and attacker:IsValid() then
                            if bullet:GetDistanceSqToInst(attacker) > hide_dissq then
                                bullet.__dis_dsp_task:Cancel()
                                bullet:Show()   
                            end
                        else
                            bullet:Remove()
                        end
                end)
            -------------------------------------------------------------------


            inst.components.stackable:Get():Remove()
        end)
    -------------------------------------------------------------------
    return inst
end

return Prefab("chemist_item_firenettles_medicine_bottle", fn, assets)
