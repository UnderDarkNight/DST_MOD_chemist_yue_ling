--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    月光转换器
    Pharmaceutical Manufacturing Station
    chemist_building_moonshine_converter

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local function GetStringsTable(name)
        local prefab_name = name or "chemist_building_moonshine_converter"
        local LANGUAGE = type(TUNING["chemist_yue_ling.Language"]) == "function" and TUNING["chemist_yue_ling.Language"]() or TUNING["chemist_yue_ling.Language"]
        return TUNING["chemist_yue_ling.Strings"][LANGUAGE][prefab_name] or {}
    end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




local assets =
{
    Asset("ANIM", "anim/chemist_building_moonshine_converter.zip"),

}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 物品接受组件
    local function acceptable_com_setup(inst)
          
                if TheWorld.ismastersim then

                    inst:AddComponent("chemist_com_acceptable")
                    inst.components.chemist_com_acceptable:SetOnAcceptFn(function(inst,item,doer)
                        local stack_num = item.components.stackable.stacksize
                        -- inst.components.chemist_com_database:Add(item.prefab,stack_num)
                        --- moonglass moon_cap
                        ---  ​1月亮碎片＝1月亮蘑菇    ​2月亮蘑菇＝1月亮碎片
                        if item.prefab == "moonglass" then
                            inst.components.chemist_com_database:Add("ret.moon_cap",stack_num)
                        elseif item.prefab == "moon_cap" then
                            inst.components.chemist_com_database:Add("ret.moonglass",stack_num*0.5)
                        end

                        item:Remove()
                        inst:PushEvent("item_accepted")
                        return true
                    end)
                end
                inst:DoTaskInTime(0,function()
                    local chemist_com_acceptable = inst.replica.chemist_com_acceptable or inst.replica._.chemist_com_acceptable
                    if chemist_com_acceptable then
                        chemist_com_acceptable:SetTestFn(function(inst,item,doer)
                            -- moonglass  moon_cap
                            if inst:HasTag("burnt") then
                                return false
                            end

                            if item and (item.prefab == "moonglass" or item.prefab == "moon_cap") then
                                return true
                            end

                            return false                    
                        end)
                        chemist_com_acceptable:SetText(inst.prefab,STRINGS.ACTIONS.ADDCOMPOSTABLE)
                        chemist_com_acceptable:SetSGAction("give")
                    end
                end)
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----
    local function item_accept_event_setup(inst)
        if not TheWorld.ismastersim then
            return
        end

        local function converter_fn()
            
            if inst.___converter_task then
                return
            end

            inst.___converter_task = inst:DoPeriodicTask(0.5,function()
                local need_2_cancel_task = true
                -----------------------------------------------------------------------------------------

                -----------------------------------------------------------------------------------------
                --- 丢出物品 moon_cap
                    if inst.components.chemist_com_database:Add("ret.moon_cap",0) >= 1 then
                        need_2_cancel_task = false
                        inst.components.chemist_com_database:Add("ret.moon_cap",-1)
                        inst.components.lootdropper:SpawnLootPrefab("moon_cap")
                    end
                -----------------------------------------------------------------------------------------
                --- 丢出物品 moonglass
                    if inst.components.chemist_com_database:Add("ret.moonglass",0) >= 1 then
                        need_2_cancel_task = false
                        inst.components.chemist_com_database:Add("ret.moonglass",-1)
                        inst.components.lootdropper:SpawnLootPrefab("moonglass")
                    end
                -----------------------------------------------------------------------------------------


                if need_2_cancel_task then
                    inst.___converter_task:Cancel()
                    inst.___converter_task = nil
                end


            end)

        end

        inst:ListenForEvent("item_accepted",converter_fn)
        inst:DoTaskInTime(0,function()
            if inst:HasTag("burnt") then
                return
            end
            converter_fn()
        end)

        inst:ListenForEvent("onburnt",function()
            if inst.___converter_task then
                inst.___converter_task:Cancel()
                inst.___converter_task = nil
            end
        end)
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("chemist_building_moonshine_converter.tex")
    -- inst.Light:SetFalloff(1)
    -- inst.Light:SetIntensity(.5)
    -- inst.Light:SetRadius(1)
    -- inst.Light:Enable(false)
    -- inst.Light:SetColour(180/255, 195/255, 50/255)

    inst.AnimState:SetBank("chemist_building_moonshine_converter")
    inst.AnimState:SetBuild("chemist_building_moonshine_converter")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("structure")
    inst:AddTag("chemist_building_moonshine_converter")

    inst.entity:SetPristine()

    -------------------------------------------------------------------------------------
    ---- 安装接受组件
        acceptable_com_setup(inst)       
    -------------------------------------------------------------------------------------
    ---- 安装 item accept event 监听
        item_accept_event_setup(inst)
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
        -- inst.components.workable:SetOnWorkCallback(function()
        --     if not inst:HasTag("burnt") then
        --         inst.AnimState:PlayAnimation("hit")
        --         inst.AnimState:PushAnimation("idle",true)
        --     end
        -- end)    
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
            inst.components.chemist_com_database:AddOnLoadFn(function()
                if inst.components.chemist_com_database:Get("burnt") then
                    inst:PushEvent("onburnt")
                    inst.components.burnable.onburnt(inst)
                end
            end)
    --------------------------------------------------------

    --------------------------------------------------------

    return inst
end

return Prefab("chemist_building_moonshine_converter", fn, assets),
        MakePlacer("chemist_building_moonshine_converter_placer", "chemist_building_moonshine_converter", "chemist_building_moonshine_converter", "idle")