local assets =
{
    Asset("ANIM", "anim/chemist_plant_wisdom_apple_tree.zip"),
}

local prefabs =
{
    -- "rock_avocado_fruit",
    -- "dug_rock_avocado_bush",
    -- "twigs",
}

local STAGE1 = "stage_1"
local STAGE2 = "stage_2"
local STAGE3 = "stage_3"
local STAGE4 = "stage_4"

local growth_stages =
{
    {
        name = STAGE1,
        time = function(inst) return GetRandomWithVariance(TUNING.ROCK_FRUIT_REGROW.EMPTY.BASE, TUNING.ROCK_FRUIT_REGROW.EMPTY.VAR) end,
        fn = function(inst)
            inst.components.pickable:ChangeProduct(nil)        
            inst.components.pickable.canbepicked = false        
            inst.AnimState:HideSymbol("apple")
            inst.AnimState:HideSymbol("flower")
            if inst.components.pickable:IsBarren() then
                inst.AnimState:OverrideSymbol("leaves_normal", "chemist_plant_wisdom_apple_tree", "leaves_barren")
            else
                inst.AnimState:ClearOverrideSymbol("leaves_normal")
            end
        end,
        growfn = function(inst)
        end,
    },
    {
        name = STAGE2,
        time = function(inst) return GetRandomWithVariance(TUNING.ROCK_FRUIT_REGROW.PREPICK.BASE, TUNING.ROCK_FRUIT_REGROW.PREPICK.VAR) end,
        fn = function(inst)
            inst.components.pickable:ChangeProduct(nil)        
            inst.components.pickable.canbepicked = false        
            inst.AnimState:HideSymbol("apple")
            inst.AnimState:ShowSymbol("flower")
            inst.AnimState:ClearOverrideSymbol("leaves_normal")
        end,
        growfn = function(inst)
        end,
    },
    {
        name = STAGE3,
        time = function(inst) return GetRandomWithVariance(TUNING.ROCK_FRUIT_REGROW.PICK.BASE, TUNING.ROCK_FRUIT_REGROW.PICK.VAR) end,
        fn = function(inst)
            inst.components.pickable:ChangeProduct("chemist_food_wisdom_apple")
            inst.components.pickable.numtoharvest = math.random(3)
            inst.components.pickable:Regen()        
            inst.AnimState:ShowSymbol("apple")
            inst.AnimState:ShowSymbol("flower")
            inst.AnimState:ClearOverrideSymbol("leaves_normal")
        end,
        growfn = function(inst)
        end,
    },
    {
        name = STAGE4,
        time = function(inst) return GetRandomWithVariance(TUNING.ROCK_FRUIT_REGROW.CRUMBLE.BASE, TUNING.ROCK_FRUIT_REGROW.CRUMBLE.VAR) end,
        fn = function(inst)
            inst.components.pickable:ChangeProduct(nil)        
            -- If we got set here directly, instead of going through stage 3, we still need to be pickable.
            if not inst.components.pickable:CanBePicked() then
                inst.components.pickable:Regen()
            end
            inst.AnimState:ShowSymbol("apple")
            inst.AnimState:ShowSymbol("flower")
            inst.AnimState:ClearOverrideSymbol("leaves_normal")
            --
        end,
        growfn = function(inst)
        end,
    },
}

local function onregenfn(inst)
    -- If we got here via debug and we're not at pickable yet, just skip us ahead to the first pickable stage.
    if inst.components.growable.stage < 3 then
        inst.components.growable:SetStage(3)
    end
end

local function on_bush_burnt(inst)
    -- Since the rock avocados themselves are rock hard, they don't burn up, but the bush does!
    if inst.components.growable.stage == 3 then
        inst.components.lootdropper:SpawnLootPrefab("rock_avocado_fruit")
        inst.components.lootdropper:SpawnLootPrefab("rock_avocado_fruit")
        inst.components.lootdropper:SpawnLootPrefab("rock_avocado_fruit")
    end

    inst.AnimState:PlayAnimation("burnt")
    -- The bush, of course, stops growing once it's been burnt.
    inst.components.growable:StopGrowing()

    DefaultBurntFn(inst)
end

local function on_ignite(inst)
    -- Function empty; we make a custom function just to bypass the persists = false portion of the default ignite function.
end

local function on_dug_up(inst, digger)

    if not inst.components.pickable:IsBarren() then
        inst.components.lootdropper:SpawnLootPrefab("chemist_plant_wisdom_apple_tree_item")
    else
        inst.components.lootdropper:SpawnLootPrefab("twigs")
    end
    if inst.components.pickable:CanBePicked() then
        local num = math.random(3)
        for i = 1, num, 1 do
            inst.components.lootdropper:SpawnLootPrefab("chemist_food_wisdom_apple")            
        end
    end

    inst:Remove()
end

local function onpickedfn(inst, picker)

    inst.components.growable:SetStage(1)

    -- Play the proper picked animation.
    if inst.components.pickable:IsBarren() then
        -- NOTE: IsBarren just tests cycles_left; MakeBarren hasn't actually been called!
        -- So we need to do the relevant parts of that function. Copied here just to not overload SetStage/animations.
        -- inst.AnimState:PushAnimation("idle1_to_dead1", false)
        -- inst.AnimState:PushAnimation("dead1", false)
        
        inst.AnimState:HideSymbol("apple")
        inst.AnimState:HideSymbol("flower")
        inst.AnimState:OverrideSymbol("leaves_normal", "chemist_plant_wisdom_apple_tree", "leaves_barren")

        inst.components.growable:StopGrowing()
        inst.components.growable.magicgrowable = false

    else
        -----------    
        if TUNING.CHEMIST_YUE_LING_DEBUGGING_MODE or math.random(1000)/1000 < 0.1 then
            inst.components.lootdropper:SpawnLootPrefab("chemist_plant_wisdom_apple_tree_item")
        end
    end
end

local function makeemptyfn(inst)
    if not POPULATING then
        -- SetStage(1) will change the animation, so store whether we came into this function dead first.
        -- local emptying_dead = inst.AnimState:IsCurrentAnimation("dead1")

        inst.components.growable:SetStage(1)
        inst.components.growable:StartGrowing()
        inst.components.growable.magicgrowable = true

        if not inst:HasTag("withered") then
            -- inst.AnimState:PlayAnimation("idle1", false)
            inst.AnimState:HideSymbol("apple")
            inst.AnimState:HideSymbol("flower")
            inst.AnimState:ClearOverrideSymbol("leaves_normal")
        else
            inst.AnimState:HideSymbol("apple")
            inst.AnimState:HideSymbol("flower")
            inst.AnimState:OverrideSymbol("leaves_normal", "chemist_plant_wisdom_apple_tree", "leaves_barren")
        end
    end
end

local function makebarrenfn(inst, wasempty)
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()
    inst.components.growable.magicgrowable = false


    inst.AnimState:HideSymbol("apple")
    inst.AnimState:HideSymbol("flower")
    inst.AnimState:OverrideSymbol("leaves_normal", "chemist_plant_wisdom_apple_tree", "leaves_barren")

end

local function ontransplantfn(inst)
    inst.components.pickable:MakeBarren()

    inst.AnimState:HideSymbol("apple")
    inst.AnimState:HideSymbol("flower")
    inst.AnimState:OverrideSymbol("leaves_normal", "chemist_plant_wisdom_apple_tree", "leaves_barren")
end

local function on_save(inst, data)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        data.burning = true
    end
end

local function on_load(inst, data)
    if data == nil then
        return
    end

    if data.burning then
        on_bush_burnt(inst)
    elseif inst.components.witherable:IsWithered() then
        inst.components.witherable:ForceWither()
    elseif not inst.components.pickable:IsBarren() and data.growable ~= nil and data.growable.stage == nil then
        -- growable doesn't call SetStage on load if the stage was saved out as nil (assuming initial state is ok).
        -- Since we randomly choose a stage on prefab creation, we want to explicitly call SetStage(1) for that case.
        inst.components.growable:SetStage(1)
    end
end

local function rock_avocado_bush()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("chemist_plant_wisdom_apple_tree")
    inst.AnimState:SetBuild("chemist_plant_wisdom_apple_tree")
    inst.AnimState:PlayAnimation("idle",true)

    inst.AnimState:HideSymbol("apple")
    inst.AnimState:HideSymbol("snow")
    inst.AnimState:HideSymbol("flower")

    MakeSmallObstaclePhysics(inst, .1)

    inst:AddTag("plant")
    inst:AddTag("renewable")
    inst:AddTag("chemist_plant_wisdom_apple_tree")

    inst.MiniMapEntity:SetIcon("chemist_plant_wisdom_apple_tree.tex")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeMediumBurnable(inst)
    inst.components.burnable:SetOnBurntFn(on_bush_burnt)
    inst.components.burnable:SetOnIgniteFn(on_ignite)

    MakeMediumPropagator(inst)

    MakeHauntableIgnite(inst)

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(on_dug_up)

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"

    -- We will have 3 rock fruit, but we only have real product for one stage, and it's not our initial stage.
    -- We use ChangeProduct to set this up elsewhere.
    inst.components.pickable.numtoharvest = 3
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.makebarrenfn = makebarrenfn
    inst.components.pickable.ontransplantfn = ontransplantfn
    inst.components.pickable.onregenfn = onregenfn

    inst.components.pickable.max_cycles = TUNING.ROCK_FRUIT_PICKABLE_CYCLES
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles

    inst:AddComponent("witherable")

    inst:AddComponent("inspectable")

    inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable.loopstages = true
    inst.components.growable.springgrowth = true
    inst.components.growable.magicgrowable = true
    inst.components.growable:SetStage(math.random(1, 4))
    inst.components.growable:StartGrowing()

    inst:AddComponent("simplemagicgrower")
    inst.components.simplemagicgrower:SetLastStage(#inst.components.growable.stages - 1)

    inst.OnSave = on_save
    inst.OnLoad = on_load

    --------------------------------------------------------
    ---- 积雪检查
        local function snow_init(inst)            
            if TheWorld.state.issnowcovered then
                inst.AnimState:ShowSymbol("snow")
            else
                inst.AnimState:HideSymbol("snow")
            end    
        end
        inst:WatchWorldState("issnowcovered", snow_init)
        snow_init(inst)
    --------------------------------------------------------

    return inst
end

return Prefab("chemist_plant_wisdom_apple_tree", rock_avocado_bush, assets, prefabs)
