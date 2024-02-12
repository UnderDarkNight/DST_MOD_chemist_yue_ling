----------------------------------------------------------------------------------------------------------------------------------
--[[

     等级系统
     
]]--
----------------------------------------------------------------------------------------------------------------------------------
local chemist_com_level_sys = Class(function(self, inst)
    self.inst = inst

    self.current_level = 0
    self.max_level = 10
    self.current_exp = 0
    self.next_level_exp = 0

    if TheWorld.ismastersim then
        -- self.temp_inst = inst:SpawnChild("chemist_other_level_classified")
        -- self.temp_inst.Ready = true
        -- self.temp_inst:DoStaticTaskInTime(0, function()
        --     self.temp_inst:PushEvent("Setup",inst)                
        -- end)
        self.classified = SpawnPrefab("chemist_other_level_classified")
        self.classified.entity:SetParent(inst.entity)
        self.classified.Network:SetClassifiedTarget(self.inst)
        self.classified.Ready = true
        self.inst:DoTaskInTime(0, function()
            self.classified:PushEvent("Setup",inst)
            self.classified.Network:SetClassifiedTarget(self.inst)
        end)

    end

    
end)

----------------------------------------------------------------------------------------------------------------------------------

    -----------------------------------------------------------
    --- current_level
        function chemist_com_level_sys:GetCurrentLevel()
            if self.classified then
                return self.classified.__current_level:value()
            end
            return self.current_level
        end
        function chemist_com_level_sys:SetCurrentLevel(value)
            -- print("fake error ++ SetCurrentLevel",value)

            if self.classified then
                self.classified.__current_level:set(value)
            end
            self.current_level = value
        end
    -----------------------------------------------------------
    --- max_level
        function chemist_com_level_sys:GetMaxLevel()
            if self.classified then
                return self.classified.__max_level:value()
            end
            return self.max_level
        end
        function chemist_com_level_sys:SetMaxLevel(value)
            if self.classified then
                self.classified.__max_level:set(value)
            end
            self.max_level = value
        end
    -----------------------------------------------------------
    ---- current_exp
        function chemist_com_level_sys:GetCurrentExp()
            if self.classified then
                return self.classified.__current_exp:value()
            end
            return self.current_exp
        end
        function chemist_com_level_sys:SetCurrentExp(value)
            if self.classified then
                self.classified.__current_exp:set(value)
            end
            self.current_exp = value
        end
    -----------------------------------------------------------
    ---- next_level_exp
        function chemist_com_level_sys:GetNextLevelExp()
            if self.classified then
                return self.classified.__next_level_exp:value()
            end
            return self.next_level_exp
        end
        function chemist_com_level_sys:SetNextLevelExp(value)
            if self.classified then
                self.classified.__next_level_exp:set(value)
            end
            self.next_level_exp = value
        end
    -----------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------

return chemist_com_level_sys






