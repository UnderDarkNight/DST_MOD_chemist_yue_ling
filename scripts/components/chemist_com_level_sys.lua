----------------------------------------------------------------------------------------------------------------------------------
--[[

     等级系统
     
     ​可以升级，满级200级，每升一级三维增加1点（需要经验药剂）
     （升级方案，1-10级每级需要一个经验药剂，11-20每级需要两个经验药剂。。。以此类推）

     1瓶药水 1EXP
     
    1 -  10 :  1 EXP
    11 - 20 : 2 EXP
    21 - 30 : 3 EXP
    ...
    191 - 200 : 20 EXP
     （更换角色等级保留）

]]--
----------------------------------------------------------------------------------------------------------------------------------
-----
    local function current_level_fn(self,num)
        local replica_com = self.inst.replica.chemist_com_level_sys or self.inst.replica._.chemist_com_level_sys
        if replica_com then
            replica_com:SetCurrentLevel(num)
        end
    end

    local function max_level_fn(self,num)
        local replica_com = self.inst.replica.chemist_com_level_sys or self.inst.replica._.chemist_com_level_sys
        if replica_com then
            replica_com:SetMaxLevel(num)
        end
    end
    local function current_exp_fn(self,num)
        local replica_com = self.inst.replica.chemist_com_level_sys or self.inst.replica._.chemist_com_level_sys
        if replica_com then
            replica_com:SetCurrentExp(num)
        end
    end

    local function next_level_exp_fn(self,num)
        local replica_com = self.inst.replica.chemist_com_level_sys or self.inst.replica._.chemist_com_level_sys
        if replica_com then
            replica_com:SetNextLevelExp(num)
        end
    end
----------------------------------------------------------------------------------------------------------------------------------
local chemist_com_level_sys = Class(function(self, inst)
    self.inst = inst

    self.current_level = 0
    self.max_level = 200

    self.current_exp = 0
    self.next_level_exp = 1
    -----------------------------------
    --- 等级 event fn
        self.level_events = self.level_events or {}
        for i = 1, self.max_level, 1 do
            self.level_events[i] = self.level_events[i] or {}
        end
    -----------------------------------

    -----------------------------------

end,
nil,
{
    current_level = current_level_fn,
    max_level = max_level_fn,
    current_exp = current_exp_fn,
    next_level_exp = next_level_exp_fn,

})



----------------------------------------------------------------------------------------------------------------------------------
--- 等级Event
    function chemist_com_level_sys:Add_Level_Event(level_num,fn)
        if type(level_num) == "number" and type(fn) == "function" then
            self.level_events = self.level_events or {}
            self.level_events[level_num] = self.level_events[level_num] or {}
            self.level_events[level_num][fn] = true
        end
    end
    function chemist_com_level_sys:Remove_Level_Event(level_num,fn)
        if type(level_num) == "number" and type(fn) == "function" then
            self.level_events = self.level_events or {}
            self.level_events[level_num] = self.level_events[level_num] or {}
            self.level_events[level_num][fn] = false
        end
    end
    function chemist_com_level_sys:Push_Level_Event(level_num)
        if type(level_num) == "number" then
            for fn,flag in pairs(self.level_events[level_num]) do
                if fn and flag then
                    fn()
                end
            end
        end
    end
----------------------------------------------------------------------------------------------------------------------------------
--- 等级的增加

    function chemist_com_level_sys:LevelUp(num)
        local old_level = self.current_level
        num = num or 1
        self.current_level = self.current_level + num
        if self.current_level > self.max_level then
            self.current_level = self.max_level
        end

        if self._on_level_changed_fn then
            self._on_level_changed_fn(self.current_level)
        end
        local new_level = self.current_level

        --------------------------------------------
        --- 每个等级触发一次event
            for i = old_level+1, new_level, 1 do
                -- print(i)
                self:Push_Level_Event(i)
            end
        --------------------------------------------
    end
    
    function chemist_com_level_sys:Get_Level()
        return self.current_level
    end

    function chemist_com_level_sys:IsMaxLevel()
        return self.current_level >= self.max_level
    end

    function chemist_com_level_sys:Add_Level_Changed_Fn(fn)
        if type(fn) == "function" then
            self._on_level_changed_fn = fn
        end
    end


----------------------------------------------------------------------------------------------------------------------------------
--- 经验值
    --[[
             （升级方案，1-10级每级需要一个经验药剂，11-20每级需要两个经验药剂。。。以此类推）
                1瓶药水 1EXP                
                1 -  10 :  1 EXP
                11 - 20 : 2 EXP
                21 - 30 : 3 EXP
                ...
                191 - 200 : 20 EXP
    ]]--
    function chemist_com_level_sys:Add_Exp(exp)
        exp = exp or 1
        self.current_exp = self.current_exp + exp
        local next_level_exp = self:Get_Next_Level_Exp()
        if next_level_exp == 0 then
            return
        end

        if self.current_exp >= next_level_exp then
            self:LevelUp(1)
            self.current_exp = self.current_exp - next_level_exp
            self:Add_Exp(0)
        else
            return
        end
    end
    function chemist_com_level_sys:Get_Next_Level_Exp()
        local current_level = self:Get_Level()
        local next_level_exp = 0
        if current_level >= self.max_level then
            next_level_exp = 0
        end

        next_level_exp = math.floor(current_level/10) + 1

        self.next_level_exp = next_level_exp

        return next_level_exp
    end
----------------------------------------------------------------------------------------------------------------------------------
--- 添加 onload fn
    function chemist_com_level_sys:SetOnLoadFn(fn)
        if type(fn) == "function" then
            self._on_load_fn = fn
        end
    end
----------------------------------------------------------------------------------------------------------------------------------
--- 储存/读取
    function chemist_com_level_sys:OnSave()
        local data =
        {
            current_level = self.current_level,
            current_exp = self.current_exp,
        }

        return next(data) ~= nil and data or nil
    end

    function chemist_com_level_sys:OnLoad(data)

        if data.current_level then
            self.current_level = data.current_level
        end
        if data.current_exp then
            self.current_exp = data.current_exp
        end


        if self._on_load_fn then
            self._on_load_fn()
        end
        local temp = self:Get_Next_Level_Exp()
    end
----------------------------------------------------------------------------------------------------------------------------------

return chemist_com_level_sys






