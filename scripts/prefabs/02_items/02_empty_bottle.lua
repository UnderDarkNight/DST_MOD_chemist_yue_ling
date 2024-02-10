------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    空药剂瓶

    medicine bottle

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_item_empty_bottle.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_item_empty_bottle.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_item_empty_bottle.xml" ),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_item_empty_bottle")
    inst.AnimState:SetBuild("chemist_item_empty_bottle")
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
    inst.components.inventoryitem.imagename = "chemist_item_empty_bottle"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_item_empty_bottle.xml"

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

    -------------------------------------------------------------------
    return inst
end

return Prefab("chemist_item_empty_bottle", fn, assets)
