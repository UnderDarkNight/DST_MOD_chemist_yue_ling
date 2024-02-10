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

    MakeInventoryFloatable(inst, "med", 0.1, 0.75)

    inst.entity:SetPristine()

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
    inst.components.stackable.maxsize = 20

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
            -- local pt = _table.pt
            -- pt.y = 1.5



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

            if inst.components.stackable.stacksize > 1 then
                inst.components.stackable.stacksize = inst.components.stackable.stacksize - 1
                print("temp ++++++++++",inst.components.stackable.stacksize )
            else
                inst:Remove()
            end
            -- inst.components.stackable:Get():Remove()
        end)
    -------------------------------------------------------------------
    return inst
end

return Prefab("chemist_item_firenettles_medicine_bottle", fn, assets)
