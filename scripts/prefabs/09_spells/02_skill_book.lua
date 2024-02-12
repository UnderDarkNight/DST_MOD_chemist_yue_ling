local assets =
{
    -- Asset("ANIM", "anim/fireflies.zip"),
}



local function builder_onbuilt(inst, builder)
    -- print(inst,builder,"fake error")
	if builder then
        if builder:HasTag("chemist_yue_ling") then

            builder.components.chemist_com_rpc_event:PushEvent("chemist_spell_skill_book_open")
        end
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

return Prefab("chemist_spell_skill_book_open", fn,assets)