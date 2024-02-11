local assets =
{
    -- Asset("ANIM", "anim/fireflies.zip"),
}



local function builder_onbuilt(inst, builder)
    -- print(inst,builder,"fake error")
	if builder then

        local item = SpawnPrefab("chemist_item_empty_bottle")

        if builder.components.sanity:IsLunacyMode() then    --- 启蒙状态做瓶子  随机得 1-5
            item.components.stackable.stacksize = math.random(5)
        end
        
        builder.components.inventory:GiveItem(item)

    end
    inst:Remove()
end

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst:AddTag("CLASSIFIED")

    inst.persists = false

    inst:DoTaskInTime(0, inst.Remove)

    


    if not TheWorld.ismastersim then
        return inst
    end

    inst.OnBuiltFn = builder_onbuilt

   
    return inst
end

return Prefab("chemist_spell_empty_bottle_maker", fn,assets)