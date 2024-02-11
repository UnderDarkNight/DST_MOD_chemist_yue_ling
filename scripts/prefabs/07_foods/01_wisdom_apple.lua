------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    智慧果

    medicine bottle

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/chemist_food_wisdom_apple.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_food_wisdom_apple.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/chemist_food_wisdom_apple.xml" ),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("chemist_food_wisdom_apple")
    inst.AnimState:SetBuild("chemist_food_wisdom_apple")
    inst.AnimState:PlayAnimation("idle")
    

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
    inst.components.inventoryitem.imagename = "chemist_food_wisdom_apple"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_food_wisdom_apple.xml"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 10


    -------------------------------------------------------------------
        inst:AddComponent("edible") -- 可食物组件
        inst.components.edible.foodtype = FOODTYPE.VEGGIE
        -- inst.components.edible:SetOnEatenFn(function(inst,eater)
        -- end)
        inst.components.edible.hungervalue = 0
        inst.components.edible.sanityvalue = 5
        inst.components.edible.healthvalue = 0
    -------------------------------------------------------------------
    return inst
end

return Prefab("chemist_food_wisdom_apple", fn, assets)
