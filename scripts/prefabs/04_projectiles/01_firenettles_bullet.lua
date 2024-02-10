local assets =
{
    Asset("ANIM", "anim/chemist_projectile_firenettles_bullet.zip"),
}

local function OnHit(inst, attacker, target)

end

local function OnAnimOver(inst)
    -- inst:DoTaskInTime(.3, inst.Remove)
end

local function OnThrown(inst)
    -- inst:ListenForEvent("animover", OnAnimOver)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    -- inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("chemist_projectile_firenettles_bullet")
    inst.AnimState:SetBuild("chemist_projectile_firenettles_bullet")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)

    --projectile (from projectile component) added to pristine state for optimization
    inst:AddTag("projectile")
    local scale = 2
    inst.AnimState:SetScale(scale, scale, scale)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:AddComponent("weapon")

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(20)
    inst.components.projectile:SetHoming(false)
    inst.components.projectile:SetHitDist(1.5)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(inst.Remove)
    -- inst.components.projectile:SetOnThrownFn(OnThrown)

    return inst
end


return Prefab("chemist_projectile_firenettles_bullet", fn, assets)