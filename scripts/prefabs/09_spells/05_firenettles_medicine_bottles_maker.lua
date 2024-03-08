local assets =
{
    -- Asset("ANIM", "anim/fireflies.zip"),
}



local function builder_onbuilt(inst, builder)
    -- print(inst,builder,"fake error")
	if builder then

        local item = SpawnPrefab("chemist_item_firenettles_medicine_bottle")
        item.components.stackable.stacksize = 20

        
        builder.components.inventory:GiveItem(item)


        local item2 = SpawnPrefab("chemist_item_firenettles_medicine_bottle")
        item2.components.stackable.stacksize = 10

        
        builder.components.inventory:GiveItem(item2)

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

return Prefab("chemist_spell_firenettles_medicine_bottle_maker", fn,assets)