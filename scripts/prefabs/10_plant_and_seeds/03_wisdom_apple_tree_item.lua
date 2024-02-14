--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
    树苗
]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local assets =
{
    Asset("ANIM", "anim/chemist_plant_wisdom_apple_tree.zip"),
    Asset( "IMAGE", "images/inventoryimages/chemist_plant_wisdom_apple_tree_item.tex" ), 
    Asset( "ATLAS", "images/inventoryimages/chemist_plant_wisdom_apple_tree_item.xml" ),
}
---------------------------------------------------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    --inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst:AddTag("deployedplant")

    inst.AnimState:SetBank("chemist_plant_wisdom_apple_tree")
    inst.AnimState:SetBuild("chemist_plant_wisdom_apple_tree")
    inst.AnimState:PlayAnimation("item")
    -- local scale = 0.5
    -- inst.AnimState:SetScale(scale,scale,scale)

    inst.entity:SetPristine()
    -------------------------------------------------------------------

    -------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end
    -------------------------------------------------------------------
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_TINYITEM

        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "chemist_plant_wisdom_apple_tree_item"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/chemist_plant_wisdom_apple_tree_item.xml"

        inst:AddComponent("fuel")
        inst.components.fuel.fuelvalue = TUNING.TINY_FUEL

        MakeMediumBurnable(inst, TUNING.TINY_BURNTIME)

    -------------------------------------------------------------------
    --- 种植组件
        inst:AddComponent("deployable")                
        inst.components.deployable.ondeploy = function(inst, pt, deployer)
            if pt and pt.x then
                local tree = SpawnPrefab("chemist_plant_wisdom_apple_tree")
                tree.components.growable:SetStage(1)
                tree.components.pickable:MakeBarren()
                tree.Transform:SetPosition(pt.x,0, pt.z)
                inst.components.stackable:Get():Remove()
            end            
        end
        inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
        inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)   
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
    return inst
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- placer post init
    local function placer_postinit_fn(inst)
        -- if inst.components.placer then
        --     inst.components.placer.override_testfn = function(inst)
        --         local x,y,z = inst.Transform:GetWorldPosition()
        --         return CanPlantAtPoint(inst, x, y, z)
        --     end
        -- end
        inst.AnimState:HideSymbol("apple")
        inst.AnimState:HideSymbol("flower")
        inst.AnimState:HideSymbol("snow")
        inst.AnimState:OverrideSymbol("leaves_normal", "chemist_plant_wisdom_apple_tree", "leaves_barren")
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return Prefab("chemist_plant_wisdom_apple_tree_item", fn, assets),
    MakePlacer("chemist_plant_wisdom_apple_tree_item_placer", "chemist_plant_wisdom_apple_tree", "chemist_plant_wisdom_apple_tree", "idle", nil, false, nil, nil, nil, nil, placer_postinit_fn, nil, nil)

