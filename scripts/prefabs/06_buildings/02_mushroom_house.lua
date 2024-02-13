--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    蘑菇房子
    chemist_building_mushroom_house

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




local assets =
{
    Asset("ANIM", "anim/chemist_building_mushroom_house.zip"),

}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- item check
    local mushrooms = {
        ["red_cap"] = true,
        ["green_cap"] = true,
        ["blue_cap"] = true,
        ["moon_cap"] = true,
    }
    local function itemCheck(item)
        return mushrooms[item.prefab] or false
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 安装容器界面
    local function container_Widget_change(theContainer)
        -----------------------------------------------------------------------------------
        ----- 容器界面名 --- 要独特一点，避免冲突
        local container_widget_name = "chemist_building_mushroom_house_widget"

        -----------------------------------------------------------------------------------
        ----- 检查和注册新的容器界面
        local all_container_widgets = require("containers")
        local params = all_container_widgets.params
        if params[container_widget_name] == nil then
            params[container_widget_name] = {
                widget =
                {
                    slotpos = {},
                    animbank = "ui_fish_box_5x4",
                    animbuild = "ui_fish_box_5x4",
                    pos = Vector3(0, 220, 0),
                    side_align_tip = 160,
                },
                type = "chest",
                acceptsstacks = true,                
            }

            for y = 2.5, -0.5, -1 do
                for x = -1, 3 do
                    table.insert(params[container_widget_name].widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
                end
            end
            ------------------------------------------------------------------------------------------
            ---- item test
                params[container_widget_name].itemtestfn =  function(container_com, item, slot)
                    return item and itemCheck(item)
                end
            ------------------------------------------------------------------------------------------

            ------------------------------------------------------------------------------------------
        end
        
        theContainer:WidgetSetup(container_widget_name)
        ------------------------------------------------------------------------
        --- 开关声音
            if theContainer.widget then
                theContainer.widget.closesound = "turnoftides/common/together/water/splash/small"
                theContainer.widget.opensound = "turnoftides/common/together/water/splash/small"
            end
        ------------------------------------------------------------------------
    end

    local function add_container_before_not_ismastersim_return(inst)
        -------------------------------------------------------------------------------------------------
        ------ 添加背包container组件    --- 必须在 SetPristine 之后，
        -- local container_WidgetSetup = "wobysmall"
        if TheWorld.ismastersim then
            inst:AddComponent("container")
            inst.components.container.openlimit = 1  ---- 限制1个人打开
            -- inst.components.container:WidgetSetup(container_WidgetSetup)
            container_Widget_change(inst.components.container)

        else
            inst.OnEntityReplicated = function(inst)
                container_Widget_change(inst.replica.container)
            end
        end
        -------------------------------------------------------------------------------------------------
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 物品接受组件
    local function acceptable_com_setup(inst)

        local accept_fns = {
            ["green_cap"] = {
                ["test_fn"] = function(inst,item,doer)
                            local item_num = item.replica.stackable:StackSize()
                            if not inst:HasTag("unlocked.green") then ---- 没解锁的时候，需要 10 个一组
                                if item_num >= 10 then
                                    return true
                                end
                            else    ---- 解锁后 10个一组
                                if item_num >= 10 then
                                    return true
                                end
                            end
                            return false
                end,
                ["onaccept_fn"] = function(inst,item,doer)
                            if not inst:HasTag("unlocked.green") then
                                item.components.stackable:Get(10):Remove()
                                inst:PushEvent("type_unlock.green")
                                return true
                            else
                                item.components.stackable:Get(10):Remove()
                                inst.components.chemist_com_database:Add("green",1)
                                inst.components.chemist_com_database:Add("level",1)
                                return true
                            end
                end
            },
            ["blue_cap"] = {
                ["test_fn"] = function(inst,item,doer)
                            local item_num = item.replica.stackable:StackSize()
                            if not inst:HasTag("unlocked.blue") then ---- 没解锁的时候，需要 10 个一组
                                if item_num >= 10 then
                                    return true
                                end
                            else    ---- 解锁后 10个一组
                                if item_num >= 10 then
                                    return true
                                end
                            end
                            return false
                end,
                ["onaccept_fn"] = function(inst,item,doer)
                            if not inst:HasTag("unlocked.blue") then
                                item.components.stackable:Get(10):Remove()
                                inst:PushEvent("type_unlock.blue")
                                return true
                            else
                                item.components.stackable:Get(10):Remove()
                                inst.components.chemist_com_database:Add("blue",1)
                                inst.components.chemist_com_database:Add("level",1)
                                return true
                            end
                end
            },
            ["moon_cap"] = {
                ["test_fn"] = function(inst,item,doer)
                            local item_num = item.replica.stackable:StackSize()
                            if not inst:HasTag("unlocked.moon") then ---- 没解锁的时候，需要 10 个一组
                                if item_num >= 10 then
                                    return true
                                end
                            else    ---- 解锁后 10个一组
                                if item_num >= 10 then
                                    return true
                                end
                            end
                            return false
                end,
                ["onaccept_fn"] = function(inst,item,doer)
                            if not inst:HasTag("unlocked.moon") then
                                item.components.stackable:Get(10):Remove()
                                inst:PushEvent("type_unlock.moon")
                                return true
                            else
                                item.components.stackable:Get(10):Remove()
                                inst.components.chemist_com_database:Add("moon",1)
                                inst.components.chemist_com_database:Add("level",1)
                                return true
                            end
                end
            },
            ["red_cap"] = {
                ["test_fn"] = function(inst,item,doer)
                            local item_num = item.replica.stackable:StackSize()
                            if item_num >= 10 then
                                return true
                            end
                end,
                ["onaccept_fn"] = function(inst,item,doer)
                            item.components.stackable:Get(10):Remove()
                            inst.components.chemist_com_database:Add("red",1)
                            inst.components.chemist_com_database:Add("level",1)
                            return true
                end
            },
        }

        if TheWorld.ismastersim then
            inst:AddComponent("chemist_com_acceptable")
            inst.components.chemist_com_acceptable:SetOnAcceptFn(function(inst,item,doer)
                if item and item.prefab and  accept_fns[item.prefab] then
                    return accept_fns[item.prefab]["onaccept_fn"](inst,item,doer)
                end
                return false
            end)
        end

        inst:DoTaskInTime(0,function()
            local replica_com = inst.replica.chemist_com_acceptable or inst.replica._.chemist_com_acceptable
            if replica_com then
                replica_com:SetTestFn(function(inst,item,doer)
                    if item and item.prefab and accept_fns[item.prefab] then
                        return accept_fns[item.prefab]["test_fn"](inst,item,doer)
                    end
                    return false
                end)

            end
        end)
    end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 解锁事件
    local function mushroom_unlocker_event_setup(inst)
        if not TheWorld.ismastersim then 
            return
        end

        inst:ListenForEvent("type_unlock.green",function()
            inst:AddTag("unlocked.green")
            inst.components.chemist_com_database:Set("unlocked.green",true)
            inst.AnimState:ShowSymbol("green")
        end)
        inst:ListenForEvent("type_unlock.blue",function()
            inst:AddTag("unlocked.blue")
            inst.components.chemist_com_database:Set("unlocked.blue",true)
            inst.AnimState:ShowSymbol("blue")
        end)
        inst:ListenForEvent("type_unlock.moon",function()
            inst:AddTag("unlocked.moon")
            inst.components.chemist_com_database:Set("unlocked.moon",true)
            inst.AnimState:ShowSymbol("moon")
        end)

        inst.components.chemist_com_database:AddOnLoadFn(function(com)
            if com:Get("unlocked.green") then
                inst:PushEvent("type_unlock.green")
            end
            if com:Get("unlocked.blue") then
                inst:PushEvent("type_unlock.blue")
            end
            if com:Get("unlocked.moon") then
                inst:PushEvent("type_unlock.moon")
            end
        end)

    end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- daily task
    local function daily_task_setup(inst)
        if not TheWorld.ismastersim then
            return
        end

        inst:WatchWorldState("cycles",function()
            local days = inst.components.chemist_com_database:Add("days",1)
            if days >= 3 then
                inst.components.chemist_com_database:Set("days",0)
                inst:PushEvent("mushroom_grow")
            end
        end)

        inst:ListenForEvent("mushroom_grow",function()
            if inst.components.container:IsFull() then
                return
            end
            local level = inst.components.chemist_com_database:Add("level",0)
            if level < 1 then
                level = 1
            end
            
            local stack_num = level*3

            ---------------------------------------
            ---- 默认红蘑菇
                local red_cap = SpawnPrefab("red_cap")
                local max_num = red_cap.components.stackable.maxsize
                if stack_num > max_num then
                    stack_num = max_num
                end
                red_cap.components.stackable.stacksize = stack_num
                inst.components.container:GiveItem(red_cap)
            ---------------------------------------
            ---- 绿蘑菇
                if inst:HasTag("unlocked.green") and not inst.components.container:IsFull() then
                    local green_cap = SpawnPrefab("green_cap")
                    green_cap.components.stackable.stacksize = stack_num
                    inst.components.container:GiveItem(green_cap)
                end
            ---------------------------------------
            ---- 蓝蘑菇
                if inst:HasTag("unlocked.blue") and not inst.components.container:IsFull() then
                    local blue_cap = SpawnPrefab("blue_cap")
                    blue_cap.components.stackable.stacksize = stack_num
                    inst.components.container:GiveItem(blue_cap)
                end
            ---------------------------------------
            ---- 月亮蘑菇
                if inst:HasTag("unlocked.moon") and not inst.components.container:IsFull() then
                    local moon_cap = SpawnPrefab("moon_cap")
                    moon_cap.components.stackable.stacksize = stack_num
                    inst.components.container:GiveItem(moon_cap)
                end
            ---------------------------------------

        end)

    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("chemist_building_mushroom_house.tex")
    -- inst.Light:SetFalloff(1)
    -- inst.Light:SetIntensity(.5)
    -- inst.Light:SetRadius(1)
    -- inst.Light:Enable(false)
    -- inst.Light:SetColour(180/255, 195/255, 50/255)

    inst.AnimState:SetBank("chemist_building_mushroom_house")
    inst.AnimState:SetBuild("chemist_building_mushroom_house")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:Hide("SNOW")
    inst.AnimState:HideSymbol("blue")
    inst.AnimState:HideSymbol("green")
    inst.AnimState:HideSymbol("moon")


    inst:AddTag("structure")
    inst:AddTag("chemist_building_mushroom_house")

    inst.entity:SetPristine()

    -------------------------------------------------------------------------------------
    ---- 用用数据库
        if TheWorld.ismastersim then
            inst:AddComponent("chemist_com_database")
        end
    -------------------------------------------------------------------------------------
    ---- 安装容器
        add_container_before_not_ismastersim_return(inst)
    -------------------------------------------------------------------------------------
    ---- 安装物品接受组件
        acceptable_com_setup(inst)
    -------------------------------------------------------------------------------------
    ---- 安装解锁事件
        mushroom_unlocker_event_setup(inst)
    -------------------------------------------------------------------------------------
    ---- 安装自动生长组件
        daily_task_setup(inst)
    -------------------------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end

        
    ----------------------------------------------------------------
    ---- 玩家检查说的话
        inst:AddComponent("inspectable")
    ----------------------------------------------------------------
    --- 官方保鲜/返鲜组件
        inst:AddComponent("preserver")  
        inst.components.preserver.perish_rate_multiplier = -1
    ----------------------------------------------------------------
    --- 敲打拆除
        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(4)
        inst.components.workable:SetOnFinishCallback(function()
            inst.components.lootdropper:DropLoot()
            inst.components.container:DropEverything()
            SpawnPrefab("chemist_fx_collapse"):PushEvent("Set",{
                pt = Vector3(inst.Transform:GetWorldPosition())
            })
            inst:Remove()
        end)
        -- inst.components.workable:SetOnWorkCallback(function()

        -- end)    
    --------------------------------------------------------
    ---- 积雪检查
        local function snow_init(inst)
            if TheWorld.state.issnowcovered then
                inst.AnimState:Show("SNOW")
                -- inst.AnimState:ShowSymbol("snow")
            else
                inst.AnimState:Hide("SNOW")
                -- inst.AnimState:HideSymbol("snow")
            end    
        end
        inst:WatchWorldState("issnowcovered", snow_init)
        snow_init(inst)
    --------------------------------------------------------

    --------------------------------------------------------
    ---- 玩家刚刚完成建造
        inst:ListenForEvent("onbuilt", function()
            inst.AnimState:PlayAnimation("place")
            inst.AnimState:PushAnimation("idle",true)
        end)
    --------------------------------------------------------
    --------------------------------------------------------

    return inst
end
-----------------------------------------------------------------
---
    local postinit_fn = function(inst)

        inst.AnimState:Hide("SNOW")
        inst.AnimState:HideSymbol("blue")
        inst.AnimState:HideSymbol("green")
        inst.AnimState:HideSymbol("moon")

    end
-----------------------------------------------------------------

return Prefab("chemist_building_mushroom_house", fn, assets),
        MakePlacer("chemist_building_mushroom_house_placer", "chemist_building_mushroom_house", "chemist_building_mushroom_house", "idle",nil,nil,nil,nil,nil,nil,postinit_fn)