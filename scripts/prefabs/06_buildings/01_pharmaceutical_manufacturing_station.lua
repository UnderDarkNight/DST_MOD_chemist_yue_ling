--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    药剂制作站
    Pharmaceutical Manufacturing Station
    chemist_building_pharmaceutical_manufacturing_station

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local function GetStringsTable(name)
        local prefab_name = name or "chemist_building_pharmaceutical_manufacturing_station"
        local LANGUAGE = type(TUNING["chemist_yue_ling.Language"]) == "function" and TUNING["chemist_yue_ling.Language"]() or TUNING["chemist_yue_ling.Language"]
        return TUNING["chemist_yue_ling.Strings"][LANGUAGE][prefab_name] or {}
    end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




local assets =
{
    Asset("ANIM", "anim/chemist_building_pharmaceutical_manufacturing_station.zip"),

}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("chemist_building_pharmaceutical_manufacturing_station.tex")
    -- inst.Light:SetFalloff(1)
    -- inst.Light:SetIntensity(.5)
    -- inst.Light:SetRadius(1)
    -- inst.Light:Enable(false)
    -- inst.Light:SetColour(180/255, 195/255, 50/255)

    inst.AnimState:SetBank("chemist_building_pharmaceutical_manufacturing_station")
    inst.AnimState:SetBuild("chemist_building_pharmaceutical_manufacturing_station")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("structure")
    inst:AddTag("chemist_building_pharmaceutical_manufacturing_station")

    inst.entity:SetPristine()

    -------------------------------------------------------------------------------------

    -------------------------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end

        inst:AddComponent("chemist_com_database")
    ----------------------------------------------------------------
    ---- 玩家检查说的话
        inst:AddComponent("inspectable")
        inst.components.inspectable.descriptionfn = function()
            if inst:HasTag("burnt") then
                return GetStringsTable()["inspect_str_burnt"]
            else
                return GetStringsTable()["inspect_str"]
            end
        end
    ----------------------------------------------------------------
    ----- 玩家靠近
        -- local playerprox = inst:AddComponent("playerprox")
        -- inst.components.playerprox:SetTargetMode(playerprox.TargetModes.AllPlayers) --- 检测每一个进出的玩家
        -- inst.components.playerprox:SetPlayerAliveMode(playerprox.AliveModes.AliveOnly)    --- 只检测活着的

        -- inst.components.playerprox:SetDist(5.5, 7)
        -- inst.components.playerprox:SetOnPlayerNear(function(inst,player)
        --     if inst:HasTag("burnt") or player:HasTag("playerghost") then
        --         return
        --     end

        --     -- inst.AnimState:PlayAnimation("working", true)

        --     -- player:AddTag("near_pharmaceutical_manufacturing_station")

        -- end)
        -- inst.components.playerprox:SetOnPlayerFar(function(inst,player)
        --     if inst:HasTag("burnt") or ( player and player:HasTag("playerghost") ) then
        --         return
        --     end
        --     -- inst.AnimState:PlayAnimation("idle", true)

        --     -- player:RemoveTag("near_pharmaceutical_manufacturing_station")

        -- end)

    ----------------------------------------------------------------
    --- 敲打拆除
        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(4)
        inst.components.workable:SetOnFinishCallback(function()
            if not inst:HasTag("burnt") then
                inst.components.lootdropper:DropLoot()
            end
            SpawnPrefab("chemist_fx_collapse"):PushEvent("Set",{
                pt = Vector3(inst.Transform:GetWorldPosition())
            })
            inst:Remove()
        end)
        inst.components.workable:SetOnWorkCallback(function()
            if not inst:HasTag("burnt") then
                inst.AnimState:PlayAnimation("hit")
                inst.AnimState:PushAnimation("idle",true)
            end
        end)    
    --------------------------------------------------------
    ---- 积雪检查
        local function snow_init(inst)
            if TheWorld.state.issnowcovered then
                inst.AnimState:Show("SNOW")
            else
                inst.AnimState:Hide("SNOW")
            end    
        end
        inst:WatchWorldState("issnowcovered", snow_init)
        snow_init(inst)
    --------------------------------------------------------
    ---- 燃烧
            ---- 燃烧
            MakeMediumBurnable(inst, nil, nil, true)
            inst:ListenForEvent("onburnt", function()          --- 烧完后执行
                inst.components.chemist_com_database:Set("burnt",true)
                inst.AnimState:PlayAnimation("burnt")
                inst:AddTag("burnt")
                snow_init(inst)            
            end)
            inst:DoTaskInTime(0,function()
                if inst.components.chemist_com_database:Get("burnt") then
                    inst:PushEvent("onburnt")
                    inst.components.burnable.onburnt(inst)
                end
            end)
            inst:ListenForEvent("onburnt",function()
                -- inst:RemoveComponent("playerprox")  --- 移除组件
                inst:RemoveComponent("prototyper")  --- 移除组件
            end)
    --------------------------------------------------------
    ---- 玩家刚刚完成建造
        -- inst:ListenForEvent("onbuilt", function()
        --     inst.AnimState:PlayAnimation("place")
        --     inst.AnimState:PushAnimation("idle",true)
        -- end)

    --------------------------------------------------------
        inst:AddComponent("prototyper") ---- 靠近触发科技的交易系统
        -- inst.components.prototyper.onturnon = prototyper_onturnon
        -- inst.components.prototyper.onturnoff = prototyper_onturnoff
        -- inst.components.prototyper.onactivate = prototyper_onactivate
        inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES[string.upper("chemist_building_pharmaceutical_manufacturing_station")]
        -- inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.ANCIENTALTAR_HIGH
        inst:ListenForEvent("builditem",function()
            -- print("item_build")
            inst.AnimState:PlayAnimation("item_build")
            inst.AnimState:PushAnimation("idle",true)
        end)
    --------------------------------------------------------

    return inst
end

return Prefab("chemist_building_pharmaceutical_manufacturing_station", fn, assets),
        MakePlacer("chemist_building_pharmaceutical_manufacturing_station_placer", "chemist_building_pharmaceutical_manufacturing_station", "chemist_building_pharmaceutical_manufacturing_station", "idle")