-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    智慧树刷新器

]]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


AddPrefabPostInit(
    "world",
    function(inst)

        ---------------------------------------------------------------------------------------------
            if not TheWorld.ismastersim then
                return
            end
        ---------------------------------------------------------------------------------------------
        ---- 洞穴里不生长
            if inst:HasTag("cave") then
                return
            end
        ---------------------------------------------------------------------------------------------

            if inst.components.chemist_com_database == nil then
                inst:AddComponent("chemist_com_database") --- 通用数据库
            end
        ---------------------------------------------------------------------------------------------


            --------- 找月台
                
            ------------------------------------------------------------------------
            ---- 
                local max_radius = 50
                local min_radius = 20
                local function get_apple_tree_spawn_pt(target)
                                    local function GetSurroundPoints(CMD_TABLE)
                                        -- local CMD_TABLE = {
                                        --     target = inst or Vector3(),
                                        --     range = 8,
                                        --     num = 8
                                        -- }
                                        if CMD_TABLE == nil then
                                            return
                                        end
                                        local theMid = nil
                                        if CMD_TABLE.target == nil then
                                            theMid = Vector3( self.inst.Transform:GetWorldPosition() )
                                        elseif CMD_TABLE.target.x then
                                            theMid = CMD_TABLE.target
                                        elseif CMD_TABLE.target.prefab then
                                            theMid = Vector3( CMD_TABLE.target.Transform:GetWorldPosition() )
                                        else
                                            return
                                        end
                                        -- --------------------------------------------------------------------------------------------------------------------
                                        -- -- 8 points
                                        -- local retPoints = {}
                                        -- for i = 1, 8, 1 do
                                        --     local tempDeg = (PI/4)*(i-1)
                                        --     local tempPoint = theMidPoint + Vector3( Range*math.cos(tempDeg) ,  0  ,  Range*math.sin(tempDeg)    )
                                        --     table.insert(retPoints,tempPoint)
                                        -- end
                                        -- --------------------------------------------------------------------------------------------------------------------
                                        local num = CMD_TABLE.num or 8
                                        local range = CMD_TABLE.range or 8
                                        local retPoints = {}
                                        for i = 1, num, 1 do
                                            local tempDeg = (2*PI/num)*(i-1)
                                            local tempPoint = theMid + Vector3( range*math.cos(tempDeg) ,  0  ,  range*math.sin(tempDeg)    )
                                            table.insert(retPoints,tempPoint)
                                        end
                            
                                        return retPoints
                            
                            
                                    end
                                    local function find_plant_pt()
                            
                                        while true do
                                            local points = GetSurroundPoints({
                                                target = target,
                                                range = math.random(min_radius,max_radius),
                                                num = math.random(30,50)
                                            })
                                            local plant_points = {}
                                            for k, temp_pt in pairs(points) do
                                                if TheWorld.Map:CanPlantAtPoint(temp_pt.x,0,temp_pt.z) then
                                                    table.insert(plant_points,temp_pt)
                                                end
                                            end
                                            if #plant_points > 0 then
                                                return plant_points[math.random(1,#plant_points)]
                                            end
                                        end
                            
                                    end
                                    return find_plant_pt()
                end
            ------------------------------------------------------------------------
            ---- 
                local function spawn_apple_trees(target)
                    local x,y,z = target.Transform:GetWorldPosition()
                    local max_tree_num = 5
                    local trees = TheSim:FindEntities(x, y, z, max_radius + 10, {"chemist_plant_wisdom_apple_tree"}, {"burnt"}, nil)

                    local need_trees = max_tree_num - #trees
                    if need_trees > 0 then
                        for i = 1, need_trees,1 do
                            local tree_pt = get_apple_tree_spawn_pt(target)
                            SpawnPrefab("chemist_plant_wisdom_apple_tree").Transform:SetPosition(tree_pt.x,0,tree_pt.z)
                        end
                    end
                end
            ------------------------------------------------------------------------
                inst:DoTaskInTime(0,function()
                    -- print("info ++++ chemist_plant_wisdom_apple_tree spawner")

                    if not TheWorld.components.chemist_com_database:Get("chemist_plant_wisdom_apple_tree.init") then
                        TheWorld.components.chemist_com_database:Set("chemist_plant_wisdom_apple_tree.init",true)
                        local moonbase = TheSim:FindFirstEntityWithTag("moonbase")
                        if moonbase then
                            spawn_apple_trees(moonbase)
                        end
                    end
                end)
                inst:WatchWorldState("cycles", function()
                    if TheWorld.state.cycles % 10 == 0 then
                        local moonbase = TheSim:FindFirstEntityWithTag("moonbase")
                        if moonbase then
                            spawn_apple_trees(moonbase)
                        end
                    end
                end)
               
            ------------------------------------------------------------------------
            

                

        ---------------------------------------------------------------------------------------------
        
    end
)


