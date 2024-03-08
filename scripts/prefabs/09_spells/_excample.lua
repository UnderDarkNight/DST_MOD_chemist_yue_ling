local assets =
{
    -- Asset("ANIM", "anim/fireflies.zip"),
}



local function builder_onbuilt(inst, builder)
    -- print(inst,builder,"fake error")
	if builder then

        local item = SpawnPrefab("chemist_item_exp_medicine3")


        
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

return Prefab("panda_spell_sanity2health", fn,assets)